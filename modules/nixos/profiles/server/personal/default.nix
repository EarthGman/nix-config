# server module for my personal servers
{ outputs, lib, config, ... }:
let
  inherit (lib) mkDefault mkIf mkEnableOption;
  cfg = config.profiles.server.personal;
in
{
  options.profiles.server.personal.enable = mkEnableOption "personal server profile";
  config = mkIf cfg.enable {
    users.users."root" = {
      openssh.authorizedKeys.keys = mkDefault [ outputs.keys.g_pub ];
    };

    nix.settings.trusted-users = [ "g" ];

    time.timeZone = "America/Chicago";
  };
}
