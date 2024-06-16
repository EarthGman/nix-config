{ pkgs, config, lib, hostname, ... }:
let
  username = "test";
  hasSecrets = builtins.pathExists ../../../../secrets/${hostname}.yaml;
  hashedPasswordFile =
    if (hasSecrets)
    then
      config.sops.secrets.${username}.path
    else
      null;
  password = if (hasSecrets) then null else "123";
in
{
  imports = lib.optionals hasSecrets [ ./sops.nix ];
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
    ];
  };
}
