{ self, ... }:
let
  profile = self + /profiles/home-manager/g.nix;
  theme = self + /profiles/home-manager/desktop-themes/faraway.nix;
in
{
  imports = [
    profile
    theme
  ];

  programs = {
    openconnect.enable = true;
    lutris.enable = true;
    moonlight.enable = true;
  };
}

