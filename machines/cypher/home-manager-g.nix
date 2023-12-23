#used as a bootstrap for home-manager config
{ pkgs-master, ... }:
let
  homeDirectory = "/home/g";
  configHome = "${homeDirectory}/.config";
in
{
  imports = [
    ../../modules/home-manager/zsh.nix
    ../../modules/home-manager/obs.nix
    ../../modules/home-manager/common.nix
    ../../modules/home-manager/firefox.nix
    ../../modules/home-manager/vscode.nix
    ../../modules/home-manager/gh.nix
    ../../modules/home-manager/dash.nix
    ../../modules/home-manager/dconf-cypher.nix
    ../../modules/home-manager/gtk.nix
    ../../modules/home-manager/wine.nix
    ../../modules/home-manager/gaming.nix
  ];
  programs.home-manager.enable = true;
  home = {
    inherit homeDirectory;
    keyboard = null;
    sessionVariables = {
      EDITOR = "code --wait";
    };
    stateVersion = "24.05";
  };
  #cross desktop group
  xdg = {
    inherit configHome;
    enable = true;
  };
}
