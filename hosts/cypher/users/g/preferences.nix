{ self, lib, ... }:
let
  template = self + /templates/home-manager/g.nix;
  theme = self + /modules/home-manager/desktop-configs/themes/april.nix;
in
{
  imports = [
    template
    theme
  ];

  programs = {

    dolphin-emu.enable = true;
    lutris.enable = true;
    davinci-resolve.enable = true;

    looking-glass.enable = true;
    looking-glass.version = "B6";

    ygo-omega.enable = true;
  };

  wayland.windowManager.hyprland.settings.monitor = [
    "DP-3, 2560x1440, 0x0, 1"
    "HDMI-A-1, 1920x1080@74.97, -1920x0, 1"
  ];
}
