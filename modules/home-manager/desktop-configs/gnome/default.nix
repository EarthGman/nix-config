{ pkgs, ... }:
{
  imports = [
    ./dconf.nix
  ];
  home.packages = (with pkgs.gnomeExtensions; [
    dash-to-panel
    vitals
  ]) ++ (with pkgs.gnome; [
    gnome-tweaks
    dconf-editor
  ]) ++ (with pkgs; [
    dconf2nix
    gnome-tilingShell
  ]);
}
