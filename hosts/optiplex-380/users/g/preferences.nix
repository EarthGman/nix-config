{ wallpapers, ... }:
let
  inherit (builtins) fetchurl;
in
{
  profiles.essentials.enable = false;
  stylix.image = fetchurl wallpapers.windows-11;
  custom.terminal = "alacritty";

  programs = {
    museeks.enable = false;
    ghex.enable = false;
    discord.enable = false;
    obs-studio.enable = false;
  };
}
