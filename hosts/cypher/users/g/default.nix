{
  pkgs,
  config,
  ...
}:
{
  sops.secrets.g_password.neededForUsers = true;
  users.users.g = {
    initialPassword = "";
    hashedPasswordFile = config.sops.secrets.g_password.path;
    password = null;
    isNormalUser = true;
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [ config.gman.ssh-keys.g ];
    extraGroups = [
      "networkmanager"
      "wheel"
      "wireshark"
      "keyd"
      "adbusers"
    ];
  };
}
