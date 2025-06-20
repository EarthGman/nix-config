{ pkgs, keys, config, ... }:
{
  sops.secrets.g.neededForUsers = true;
  users.users.g = {
    isNormalUser = true;
    extraGroups = [ "wheel" "wireshark" ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [ keys.g_ssh_pub ];
    hashedPasswordFile = config.sops.secrets.g.path;
  };
}
