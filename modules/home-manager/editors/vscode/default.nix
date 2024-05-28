{ pkgs, lib, config, ... }:
let
  settings = config.home.homeDirectory + "/src/nix-config/modules/home-manager/editors/vscode/settings.json";
in
{
  options.vscode.enable = lib.mkEnableOption "enable vscode";
  config = lib.mkIf config.vscode.enable {
    home = {
      # symlinks the vscode settings to the settings.json in this directory
      # I do it this way instead of declaring it with HM because it will allow the user to adjust the settings using the vscode interface.
      file.".config/Code/User/settings.json".source = config.lib.file.mkOutOfStoreSymlink settings;
      packages = with pkgs; [
        nixpkgs-fmt
      ];
    };

    programs.vscode = {
      package = pkgs.vscode-fhs;
      enable = true;
      extensions = with pkgs.vscode-extensions; [
        # nix
        bbenoist.nix
        jnoortheen.nix-ide
        b4dm4n.vscode-nixpkgs-fmt

        # cpp
        ms-vscode.cpptools
        ms-vscode.cmake-tools

        # python
        ms-python.vscode-pylance

        # lua
        sumneko.lua

        # utilities
        naumovs.color-highlight
        vscode-icons-team.vscode-icons
        tomoki1207.pdf
      ];
    };
  };
}
