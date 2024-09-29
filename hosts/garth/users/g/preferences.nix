{ self, ... }:
let
  template = self + /templates/home-manager/g.nix;
  theme = self + /modules/home-manager/desktop-configs/themes/faraway.nix;
in
{
  imports = [
    template
    theme
  ];

  programs = {
    openconnect.enable = true;
    lutris.enable = true;
    moonlight.enable = true;
  };
}

