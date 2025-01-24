{ pkgs, outputs, config, ... }:
{
  sops.secrets.g.neededForUsers = true;
  users.users.g = {
    isNormalUser = true;
    extraGroups = [ "wheel" "wireshark" ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [ outputs.keys.g_pub ];
    hashedPasswordFile = config.sops.secrets.g.path;
  };
}
