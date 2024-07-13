{ pkgs, config, lib, ... }:
let
  username = "sniffer";
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
      "libvirtd"
      "qemu-libvirtd"
    ];
  };
}
