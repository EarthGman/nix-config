{ pkgs, config, lib, ... }:
let
  username = "bean";
in
{
  users.users.${username} = {
    hashedPassword = "$y$j9T$w5v0.7p6Id3n8M9LqIdvq0$HVpB/nfJo2qGCcci/ahRndyKS19A5jvbkkozOvYEKbA";
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