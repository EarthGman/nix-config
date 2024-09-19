{ self, icons, wallpapers, ... }:
let
  template = self + /templates/home-manager/g.nix;
in
{
  imports = [
    template
  ];

  stylix.image = builtins.fetchurl wallpapers.fiery-dragon;
  stylix.colorScheme = "inferno";

  programs = {
    fastfetch.image = builtins.fetchurl icons.nixos-clean;
    firefox.theme.name = "shyfox";
    firefox.theme.config.wallpaper = builtins.fetchurl wallpapers.fire-and-flames;

    openconnect.enable = true;
    lutris.enable = true;
    moonlight.enable = true;
  };
}

