{ pkgs, ... }:
{
  imports = [
    ./dconf.nix
  ];
  home.packages = with pkgs.gnomeExtensions; [
    dash-to-panel
    vitals
  ];
}
