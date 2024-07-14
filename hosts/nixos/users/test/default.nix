{ pkgs, config, lib, hostname, ... }:
let
  username = "test";
in
{
  users.users.${username} = {
    password = "123";
    isNormalUser = true;
    description = username;
    packages = with pkgs; [ home-manager ];
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };
}
