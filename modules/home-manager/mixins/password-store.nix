{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.gman.password-store;
in
{
  options.gman.password-store.enable = lib.mkEnableOption "gman's password store module";

  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      {
        programs = {
          # enable gnupg for key managment
          gpg.enable = true;

          password-store = {
            enable = true;
            # add otp support for pass
            package = (pkgs.pass.withExtensions (exts: [ exts.pass-otp ]));
          };
        };

        services = {
          # add agent for gpg key caching
          gpg-agent = {
            enable = true;
            # ensure that a pinentry program is provided
            pinentry.package = lib.mkOverride 899 pkgs.pinentry-tty;
          };

          # pass-secret-service = {
          #   enable = true;
          # };
        };
      }
      (lib.mkIf (config.meta.desktop != "") {
        services.gpg-agent.pinentry.package = pkgs.pinentry-gnome3;
      })
    ]
  );
}
