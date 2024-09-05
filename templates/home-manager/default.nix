{ pkgs, lib, ... }:
let
  inherit (lib) mkDefault;
in
{
  custom = {
    preferredEditor = mkDefault "codium";
    terminal = mkDefault "kitty";
    zsh.enable = mkDefault true;
    firefox.enable = mkDefault true;
    gnome-calculator.enable = mkDefault true;
    nautilus.enable = mkDefault true;
    fastfetch.enable = mkDefault true;
    evince.enable = mkDefault true;
    switcheroo.enable = mkDefault true;
    vlc.enable = mkDefault true;
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
