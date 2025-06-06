{ lib, config, ... }:
# many essential programs for a desktop setup.
let
  inherit (lib) mkEnableOption mkIf;
  enabled = { enable = lib.mkDefault true; };
  cfg = config.profiles.essentials;
in
{
  options.profiles.essentials.enable = mkEnableOption "essentials for linux desktop";
  config = mkIf cfg.enable {
    profiles.cli-tools.enable = true;
    # browser, file manager, and terminal are enabled using the custom attribute set
    # by default these enable: firefox, nautilus, and kitty
    programs = {
      pwvucontrol = enabled; # volume control
      fastfetch = enabled; # you know
      lazygit = enabled; # git tool
      clipgrab = enabled; # video downloader
      audacity = enabled; # audio editor
      libreoffice = enabled; # free version of office
      gimp = enabled; # image editor
      gthumb = enabled; # image viewer
      gparted = enabled; # disk partitioning tool
      evince = enabled; # pdf viewer
      vlc = enabled; # video player
      # gscan2pdf = enabled; # document scanner - broken in nixos-unstable 1-10-2025
      simple-scan = enabled;
      gnome-system-monitor = enabled; # cool task manager
      gnome-calculator = enabled; # calculator
      thunderbird = enabled; # email client
      switcheroo = enabled; # super easy image format conversion
      video-trimmer = enabled; # easy way to edit and trim videos
      obsidian = enabled; # note taking
      fzf = enabled; # shell fuzzy finder
    };
  };
}
