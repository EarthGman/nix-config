{ self, icons, ... }:
let
  template = self + /templates/home-manager/g.nix;
  theme = self + /modules/home-manager/desktop-configs/themes/inferno.nix;
in
{
  imports = [
    template
    theme
  ];

  programs = {
    fastfetch.image = builtins.fetchurl icons.nixos-clean;

    openconnect.enable = true;
    lutris.enable = true;
    moonlight.enable = true;
  };
}

