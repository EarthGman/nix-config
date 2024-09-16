{ wallpapers, ... }:
let
  inherit (builtins) fetchurl;
in
{
  stylix.image = fetchurl wallpapers.survivors;
  stylix.colorScheme = "vibrant-cool";

  custom.preferredEditor = "codium";

  programs = {
    firefox.enable = true;
    firefox.theme.name = "shyfox";
    firefox.theme.config.wallpaper = fetchurl wallpapers.get-mooned;

    bottles.enable = true;
    lutris.enable = true;
    prismlauncher.enable = true;
    discord.enable = true;
    gimp.enable = true;
    yazi.enable = true;

    museeks.enable = true;
    clipgrab.enable = true;
    obs-studio.enable = true;
    openshot.enable = true;

    audacity.enable = true;
    pwvucontrol.enable = true;
    libreoffice.enable = true;
    totem.enable = true;
    evince.enable = true;
    fastfetch.enable = true;
    gnome-calculator.enable = true;
    gnome-system-monitor.enable = true;
    gthumb.enable = true;
    switcheroo.enable = true;
    nautilus.enable = true;
  };
}
