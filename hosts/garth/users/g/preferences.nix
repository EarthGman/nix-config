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

  programs = {
    openconnect.enable = true;
    lutris.enable = true;
    moonlight.enable = true;
    gnome-clocks.enable = true;

    fastfetch.imageRandomizer = {
      enable = true;
      images = [
        (fetchurl icons.oops)
        (fetchurl icons.nixos-clean)
        (fetchurl icons.kaori)
      ];
    };
  };
}

