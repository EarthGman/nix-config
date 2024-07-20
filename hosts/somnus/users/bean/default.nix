{ pkgs, config, lib, hostname, self, ... }:
let
  username = "bean";
  hasSecrets = builtins.pathExists (self + /secrets/${hostname}.yaml);
  hashedPasswordFile =
    if (hasSecrets)
    then
      config.sops.secrets.${username}.path
    else
      null;
  password = if (hasSecrets) then null else "123";
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
