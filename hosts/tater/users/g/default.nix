{ pkgs, config, lib, ... }:
let
  username = "g";
in
{
  users.users.${username} = {
    hashedPassword = "$y$j9T$dOyX2O3/YiszsmZC3WBlA0$/UZDYx6/11rsE6DDvPxpFSJo2YvxNIOl2pAz5W.kdg3";
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
