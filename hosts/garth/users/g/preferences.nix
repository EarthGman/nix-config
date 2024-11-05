{ self, icons, ... }:
let
  inherit (builtins) fetchurl;
  theme = self + /profiles/home-manager/desktop-themes/faraway.nix;
in
{
  imports = [
    theme
  ];

  xsession.screensaver = {
    enable = true;
  };

  programs = {
    openconnect.enable = true;
    lutris.enable = true;
    moonlight.enable = true;
    gnome-clocks.enable = true;
  };
}

