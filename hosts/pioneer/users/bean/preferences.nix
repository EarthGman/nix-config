{ self, ... }:
let
  theme = self + /profiles/home-manager/desktop-themes/determination.nix;
in
{
  imports = [
    theme
  ];

  xsession.screensaver = {
    enable = true;
  };

  programs = {
    discord.enable = true;
  };

  services.polybar.settings = {
    "bar/bottom" = {
      font-0 = "MesloLGS Nerd Font Mono:size = 12;4";
      modules-left = "wlan cpu memory";
    };
  };
}
