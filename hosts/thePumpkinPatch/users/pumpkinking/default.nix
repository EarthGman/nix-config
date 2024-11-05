{ pkgs, ... }:
let
  username = "pumpkinking";
in
{
  users.users.${username} = {
    hashedPassword = "$y$j9T$4LJsU4YdDTnD8G2ru0KSE1$f/m/2edniMNLD8DawdBzFVDnt50mnMO521r4AiYUqW5";
    isNormalUser = true;
    description = username;
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
      "nordvpn"
    ];
  };
}
