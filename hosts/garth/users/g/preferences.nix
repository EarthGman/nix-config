{ self, icons, ... }:
let
  inherit (builtins) fetchurl;
  profile = self + /profiles/home-manager/g.nix;
  theme = self + /profiles/home-manager/desktop-themes/faraway.nix;
in
{
  imports = [
    profile
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

