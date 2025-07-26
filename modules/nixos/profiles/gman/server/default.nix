# server module for my personal servers
{ lib, config, ... }@args:
let
  keys = if args ? keys then args.keys else null;
  inherit (lib) mkIf mkEnableOption;
  cfg = config.profiles.gman.server;
in
{
  options.profiles.gman.server.enable = mkEnableOption "personal server profile";
  config = mkIf cfg.enable {
    users.users."root" = {
      openssh.authorizedKeys.keys = mkIf (keys != null) [ keys.g_ssh_pub ];
    };

    nix.settings.trusted-users = [ "g" ];

    time.timeZone = "America/Chicago";
  };
}
