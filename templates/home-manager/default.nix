{ lib, ... }:
let
  enabled = { enable = lib.mkDefault true; };
in
{
  custom = {
    preferredEditor = lib.mkDefault "codium";
    bottles = enabled;
    clipgrab = enabled;
    zsh = enabled;
    firefox = enabled;
    gnome-calculator = enabled;
    gnome-system-monitor = enabled;
    gthumb = enabled;
    gimp = enabled;
    gcolor = enabled;
    musescore = enabled;
    nautilus = enabled;
    fastfetch = enabled;
    evince = enabled;
    vlc = enabled;
    libreoffice = enabled;
    museeks = enabled;
    obsidian = enabled;
    prismlauncher = enabled;
    pwvucontrol = enabled;
    thunderbird = enabled;
    discord = enabled;
    xclicker = enabled;
    yazi = enabled;

    # fun and useless
    pipes = enabled;
    cbonsai = enabled;
    cmatrix = enabled;
  };
}
