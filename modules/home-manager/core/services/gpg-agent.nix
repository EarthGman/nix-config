{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.services.gpg-agent;
in
{
  options.services.gpg-agent.pam = {
    enable = lib.mkEnableOption "gpg-agent pam integration";
    keygrips = lib.mkOption {
      description = "list of gpg keygrips to be unlocked on login";
      type = lib.types.listOf lib.types.str;
      default = [ ];
    };
  };

  config = lib.mkIf cfg.pam.enable {
    services.gpg-agent.extraConfig = ''
      allow-preset-passphrase
    '';
    xdg.configFile."pam-gnupg" = {
      text = ''
        # generated and managed by home-manager
      ''
      + lib.concatStringsSep "\n" cfg.pam.keygrips;
    };
  };
}
