{ config, lib, myLib, users, ... }:
let
  usernames = myLib.splitToList users;
in
{
  options.custom.decreased-security.nixos-rebuild = lib.mkEnableOption "allow nixos-rebuild without a password";
  config = {
    security.sudo.extraRules = [
      {
        # for all users might change later idk
        users = usernames;
        commands = lib.optionals config.custom.decreased-security.nixos-rebuild [
          {
            command = "/run/current-system/sw/bin/nixos-rebuild";
            options = [ "NOPASSWD" ];
          }
        ];
      }
    ];
  };
}