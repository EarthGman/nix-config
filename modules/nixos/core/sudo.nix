{ config, lib, ... }@args:
let
  cfg = config.custom.decreased-security;
  users = if args ? users then args.users else [ ];
in
{
  options.custom.decreased-security.nixos-rebuild = lib.mkEnableOption "allow nixos-rebuild without a password";
  config = {
    security.sudo.extraRules = [
      {
        # for all users might change later idk
        inherit users;
        commands = lib.optionals cfg.nixos-rebuild [
          {
            command = "/run/current-system/sw/bin/nixos-rebuild";
            options = [ "NOPASSWD" ];
          }
        ];
      }
    ];
  };
}
