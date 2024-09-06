{ pkgs, lib, ... }:
let
  inherit (lib) mkDefault;
in
{
  custom = {
    preferredEditor = mkDefault "codium";
    terminal = mkDefault "kitty";
    bottles.enable = mkDefault true;
    clipgrab.enable = mkDefault true;
    zsh.enable = mkDefault true;
    firefox.enable = mkDefault true;
    gnome-calculator.enable = mkDefault true;
    gnome-system-monitor.enable = mkDefault true;
    gthumb.enable = mkDefault true;
    gimp.enable = true;
    gcolor.enable = true;
    musescore.enable = true;
    nautilus.enable = mkDefault true;
    fastfetch.enable = mkDefault true;
    evince.enable = mkDefault true;
    vlc.enable = mkDefault true;
    libreoffice.enable = mkDefault true;
    museeks.enable = mkDefault true;
    obsidian.enable = mkDefault true;
    prismlauncher.enable = mkDefault true;
    pwvucontrol.enable = mkDefault true;
    thunderbird.enable = mkDefault true;
    discord.enable = mkDefault true;
    xclicker.enable = mkDefault true;
    yazi.enable = mkDefault true;

    # fun and useless
    pipes.enable = mkDefault true;
    cbonsai.enable = mkDefault true;
  };
  gtk = {
    enable = true;
    iconTheme = mkDefault {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
  };
  qt = {
    enable = true;
    platformTheme.name = "adwaita";
    style.name = "adwaita-dark";
    style.package = pkgs.adwaita-qt;
  };
}
