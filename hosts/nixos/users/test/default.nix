{ pkgs, ... }:
let
  username = "test";
in
{
  users.users.${username} = {
    password = "123";
    isNormalUser = true;
    description = username;
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };
}
