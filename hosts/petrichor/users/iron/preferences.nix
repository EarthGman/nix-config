{ wallpapers, ... }:
let
  inherit (builtins) fetchurl;
in
{

  stylix.image = fetchurl wallpapers.survivors;
  stylix.colorScheme = "vibrant-cool";

  custom = {
    #firefox
    firefox.theme.name = "shyfox";
    firefox.theme.config.wallpaper = fetchurl wallpapers.get-mooned;

    lutris.enable = true;
    prismlauncher.enable = true;
    discord.enable = true;
    gimp.enable = true;
    yazi.enable = true;

    evince.enable = true;
    fastfetch.enable = true;
    gnome-calculator.enable = true;
    gnome-system-monitor.enable = true;
    gthumb.enable = true;
    switcheroo.enable = true;
  };
}
