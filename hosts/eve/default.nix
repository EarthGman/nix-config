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

  # import configuration files that match a particular username from this directory
  home-manager.profilesDir = ../../home;
}
