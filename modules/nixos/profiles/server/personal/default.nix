# server module for my personal servers
{ keys, lib, config, ... }:
let
  inherit (lib) mkDefault mkIf mkEnableOption;
  cfg = config.profiles.server.personal;
in
{
  options.profiles.server.personal.enable = mkEnableOption "personal server profile";
  config = mkIf cfg.enable {
    users.users."root" = {
      openssh.authorizedKeys.keys = mkDefault [ keys.g_ssh_pub ];
    };

    nix.settings.trusted-users = [ "g" ];

    time.timeZone = "America/Chicago";
  };
}
