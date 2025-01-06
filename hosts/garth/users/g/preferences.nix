{ outputs, lib, wallpapers, ... }:
let
  theme = outputs.homeProfiles.desktopThemes.celeste;
  inherit (builtins) fetchurl;
in
{
  imports = [
    theme
  ];

  xsession.screensaver = {
    enable = true;
  };

  services.swww.slideshow = {
    enable = true;
    images = with wallpapers; [
      (fetchurl celeste)
      (fetchurl celeste-mountain)
      (fetchurl scarlet-tree-dark)
    ];
  };

  programs = {
    # openconnect.enable = true;
    lutris.enable = true;
    moonlight.enable = true;
    gnome-clocks.enable = true;
  };

  services.dunst.battery-monitor.enable = true;
}
