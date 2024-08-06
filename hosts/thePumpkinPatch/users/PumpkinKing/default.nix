{ pkgs, ... }:
let
  username = "PumpkinKing";
in
{
  users.users.${username} = {
    hashedPassword = "$y$j9T$4LJsU4YdDTnD8G2ru0KSE1$f/m/2edniMNLD8DawdBzFVDnt50mnMO521r4AiYUqW5";
    isNormalUser = true;
    description = username;
    packages = with pkgs; [ home-manager ];
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
      "libvirtd"
      "qemu-libvirtd"
    ];
  };
}
