{ outputs, pkgs, config, lib, ... }:
let
  username = "g";
in
{
  sops.secrets.${username}.neededForUsers = true;
  users.users.${username} = {
    initialPassword = "";
    hashedPasswordFile = lib.mkIf (config.sops.secrets ? ${username}) config.sops.secrets.${username}.path;
    password = null;
    isNormalUser = true;
    openssh.authorizedKeys.keys = [ outputs.keys.g_pub ];
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };
}
