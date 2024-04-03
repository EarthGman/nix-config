{ pkgs, config, ... }:
let
  src = config.home.homeDirectory + "/src/nix-config";
  settings = src + "/modules/home-manager/vscode/settings.json";
in
{
  home = {
    file.".config/Code/User/settings.json".source = config.lib.file.mkOutOfStoreSymlink settings;
    packages = with pkgs; [
      # formatter for nix
      nixpkgs-fmt
      nixd
    ];
  };
  programs.vscode = {
    package = pkgs.vscode-fhs;
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      ms-vscode.cpptools
      ms-vscode.cmake-tools
      # ms-python.python
      ms-python.vscode-pylance
      b4dm4n.vscode-nixpkgs-fmt
      bbenoist.nix
      jnoortheen.nix-ide
      sumneko.lua
      naumovs.color-highlight
      vscode-icons-team.vscode-icons
      tomoki1207.pdf
    ];
  };
}
