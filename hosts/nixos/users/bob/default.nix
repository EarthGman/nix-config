{ pkgs, ... }:
{
  users.users.bob = {
    isNormalUser = true;
    description = "bob";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;
    password = "123";
  };
}
