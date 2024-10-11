{ self, ... }:
let
  theme = self + /modules/home-manager/desktop-configs/themes/vibrant-cool.nix;
in
{
  imports = [ theme ];

  custom.editor = "codium";

  programs = {
    firefox.enable = true;

    bottles.enable = true;
    lutris.enable = true;
    prismlauncher.enable = true;
    discord.enable = true;
    gimp.enable = true;
    yazi.enable = true;

    sl.enable = true;
    cbonsai.enable = true;
    cmatrix.enable = true;
    pipes.enable = true;

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
