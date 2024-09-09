{ pkgs, config, lib, ... }:
let
  username = "g";
in
{
  sops.secrets.${username}.neededForUsers = true;
  users.users.${username} = {
    initialPassword = "";
    hashedPasswordFile = lib.mkIf (config.sops.secrets ? ${username}) config.sops.secrets.${username}.path;
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
      "libvirtd"
      "qemu-libvirtd"
    ];
  };
}
