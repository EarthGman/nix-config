#used as a bootstrap for home-manager config
{ pkgs-master, ... }:
let
  homeDirectory = "/home/g";
  configHome = "${homeDirectory}/.config";
in
{
  imports = [
    ../../home-manager/programs.nix
    ../../home-manager/obs.nix
    ../../home-manager/packages.nix
    ../../home-manager/firefox.nix
    ../../home-manager/vscode.nix
    ../../home-manager/gh.nix
    ../../home-manager/dash.nix
    ../../home-manager/dconf-garth.nix
  ];
  programs.home-manager.enable = true;
  home = {
    inherit homeDirectory;
    sessionVariables = {
      EDITOR = "code --wait";
    };
    stateVersion = "23.11";
  };
  #cross desktop group
  xdg = {
    inherit configHome;
    enable = true;
  };
  #GUI toolkit
  gtk = {
    enable = true;
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
      gtk-button-images = false;
      gtk-menu-images = false;
      gtk-toolbar-style = "GTK_TOOLBAR_ICONS";
    };
  };
}
