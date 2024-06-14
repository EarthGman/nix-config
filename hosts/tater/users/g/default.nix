{ pkgs, config, ... }:
let
  username = "g";
  hashedPasswordFile = config.sops.secrets.${username}.path;
  password = if !(builtins.pathExists hashedPasswordFile) then "123" else null;
in
{
  sops.secrets.${username}.neededForUsers = true;
  users.mutableUsers = false;

  users.users.${username} = {
    inherit password;
    inherit hashedPasswordFile;
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
