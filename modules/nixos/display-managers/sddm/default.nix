{ self, pkgs, lib, config, hostname, displayManagerTheme, desktop, ... }:
let
  hasTheme = (displayManagerTheme != null);
  cfg = config.services.displayManager.sddm;
  inherit (lib) types mkOption;
in
{
  options.services.displayManager.sddm.themeConfig = mkOption {
    description = ''
      sddm theme configuration written to
      theme.conf.user
    '';
    default = { };
    type = types.attrsOf types.str;
  };
  config =
    let
      themePackage = pkgs.sddm-themes.${displayManagerTheme}.override {
        inherit (cfg) themeConfig;
      };
    in
    {
      services.displayManager.sddm = {
        enable = true;
        package = pkgs.kdePackages.sddm;
        wayland = {
          enable = true;
        };
        extraPackages = lib.mkIf hasTheme (with pkgs; [
          themePackage
        ]);
        theme = lib.mkIf hasTheme "${displayManagerTheme}";
      };
      environment.systemPackages = lib.mkIf hasTheme [
        themePackage
      ];
    };
}
