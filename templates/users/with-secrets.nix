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
    extraGroups = [
      "wheel"
    ];
  };
}
