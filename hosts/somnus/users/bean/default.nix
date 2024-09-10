{ pkgs, config, lib, ... }:
let
  username = "bean";
in
{
  users.users.${username} = {
    initialPassword = lib.mkDefault "";
    hashedPasswordFile = lib.mkIf (config.sops.secrets ? "${username}") config.sops.secrets.${username}.path;
    isNormalUser = true;
    description = username;
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
      "libvirtd"
      "qemu-libvirtd"
    ];
  };
}
