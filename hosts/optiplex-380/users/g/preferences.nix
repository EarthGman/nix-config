{ wallpapers, ... }:
let
  inherit (builtins) fetchurl;
in
{
  profiles.essentials.enable = false;
  stylix.image = fetchurl wallpapers.windows-11;
}
