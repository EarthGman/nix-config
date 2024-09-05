{ pkgs, lib, config, ... }:
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
  };
  gtk = {
    enable = true;
    iconTheme = mkDefault {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
  };
}
