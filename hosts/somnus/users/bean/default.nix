{ pkgs, config, lib, ... }:
let
  username = "bean";
  secret-path = config.sops.secrets.${username}.path;
  hashedPasswordFile = if builtins.pathExists (secret-path) then secret-path else null;
  # failsafe for sops
  password = if (hashedPasswordFile == null) then "123" else null;
in
{
  users.users.${username} = {
    inherit hashedPasswordFile;
    inherit password;
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
