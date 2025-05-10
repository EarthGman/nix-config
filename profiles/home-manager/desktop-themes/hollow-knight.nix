{ wallpapers, lib, ... }:
let
  inherit (builtins) fetchurl;
  inherit (lib) mkForce;
in
{
  stylix.image = mkForce (fetchurl wallpapers.hallownest-bench);

  programs.firefox.theme = {
    name = "shyfox";
    config.wallpaper = fetchurl wallpapers.ghost-and-hornet;
  };
}
