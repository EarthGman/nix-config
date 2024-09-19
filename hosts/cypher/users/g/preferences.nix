{ self, lib, myLib, wallpapers, icons, desktop, ... }:
let
  desktops = myLib.splitToList desktop;
  template = self + /templates/home-manager/g.nix;
in
{
  imports = [
    template
  ];

  stylix.image = builtins.fetchurl wallpapers.kaori;
  stylix.colorScheme = "april";

  programs = {
    fastfetch.image = builtins.fetchurl icons.kaori;
    firefox.theme.name = "shyfox";
    firefox.theme.config.wallpaper = builtins.fetchurl wallpapers.april-night;

    dolphin-emu.enable = true;
    lutris.enable = true;
    davinci-resolve.enable = true;

    looking-glass.enable = true;
    looking-glass.version = "B6";

    ygo-omega.enable = true;
  };

  wayland.windowManager.hyprland.settings.monitor = lib.mkIf (builtins.elem "hyprland" desktops) [
    "DP-3, 2560x1440, 0x0, 1"
    "HDMI-A-1, 1920x1080@74.97, -1920x0, 1"
  ];
}
