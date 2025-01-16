{ pkgs, ... }:
{
  imports = [
    ./dconf.nix
  ];
  programs.ghostty.settings.gtk-titlebar = true;
  home.packages = (with pkgs.gnomeExtensions; [
    dash-to-panel
    vitals
    arcmenu
  ]) ++ (with pkgs; [
    dconf2nix
    gnome-tweaks
    dconf-editor
  ]);
}
