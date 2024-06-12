{ pkgs, username, config, ... }:
{
  programs = {
    zsh.enable = true;
  };

  # sops.secrets.${username}.neededForUsers = true;
  users.mutableUsers = false;

  users.users.${username} = {
    isNormalUser = true;
    description = username;
    password = "123";
    # hashedPasswordFile = config.sops.secrets.${username}.path;
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };
}
