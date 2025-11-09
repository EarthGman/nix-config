# TODO configure hyprland screenshot key to Alt_R
{
  pkgs,
  lib,
  config,
  ...
}:
{
  # kernel and fstab configuration
  imports = [ ./hardware-configuration.nix ];

  time.timeZone = "America/Chicago";

  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver.xkb.layout = "us";

  users.mutableUsers = false;

  programs = {
    thunderbird.enable = true;
    discord.enable = true;
    libreoffice.enable = true;
    obsidian.enable = true;
    zotero.enable = true;
    bottles.enable = true;
    filezilla.enable = true;
    freetube.enable = true;
    ani-cli.enable = true;
  };
}
