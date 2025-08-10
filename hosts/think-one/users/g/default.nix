{
  pkgs,
  config,
  lib,
  ...
}:
let
  username = "g";
in
{
  sops.secrets.${username}.neededForUsers = true;
  users.users.${username} = {
    initialPassword = "";
    hashedPasswordFile = config.sops.secrets.${username}.path;
    password = null;
    isNormalUser = true;
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [ config.gman.ssh-keys.g ];
    extraGroups = [
      "networkmanager"
      "wheel"
      "wireshark"
      "adbusers"
    ];
  };
}
