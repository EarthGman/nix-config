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
    ];
  };
  programs.vscode = {
    package = pkgs.vscode-fhs;
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      xaver.clang-format
      ms-vscode.cpptools
      ms-vscode.cmake-tools
      bbenoist.nix
      jnoortheen.nix-ide
      sumneko.lua
      vscode-icons-team.vscode-icons
    ];
  };
}
