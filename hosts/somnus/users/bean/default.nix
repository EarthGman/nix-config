{
  pkgs,
  config,
  lib,
  ...
}:
let
  username = "bean";
in
{
  sops.secrets.${username}.neededForUsers = true;
  users.users.${username} = {
    initialPassword = lib.mkDefault "";
    password = null;
    hashedPasswordFile = lib.mkIf (
      config.sops.secrets ? "${username}"
    ) config.sops.secrets.${username}.path;
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
