# seperate user for KDE plasma due to gtk conflicts in home directory with other desktops
{ pkgs, ... }:
let
  username = "plasma";
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
