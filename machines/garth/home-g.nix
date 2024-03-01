#used as a bootstrap for home-manager config
{ pkgs, lib, config, inputs, outputs, ... }:
let
  homeDirectory = "/home/g";
  configHome = "${homeDirectory}/.config";
in
{
  imports = [
    ../../modules/home-manager/common.nix
    ../../modules/home-manager/gh.nix
    ../../modules/home-manager/gnome-extensions.nix
    ../../modules/home-manager/dconf.nix
    ../../modules/home-manager/gtk.nix
    ../../modules/home-manager/wine.nix
    ../../modules/home-manager/firefox
    ../../modules/home-manager/neofetch
    ../../modules/home-manager/vscode
    ../../modules/home-manager/wezterm
    ../../modules/home-manager/zsh
  ];
  programs.home-manager.enable = true;

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      permittedInsecurePackages = [
        "electron-25.9.0"
        "electron-19.1.9"
      ];
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = [ "nix-command" "flakes" "repl-flake" ];
    };
  };

  home = {
    inherit homeDirectory;
    username = "g";
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
