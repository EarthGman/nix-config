{ pkgs, ... }:
{
  imports = [
    ./dconf.nix
  ];
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
