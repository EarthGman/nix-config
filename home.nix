{ outputs, lib, ... }:
let
  programsDir = ./modules/home-manager/programs;
  programs = lib.forEach (builtins.attrNames (builtins.readDir programsDir)) (dirname: programsDir + /${dirname});
in
{
  programs.home-manager.enable = true;

  imports = programs;

  home = {
    username = "test";
    homeDirectory = "/home/test";
    stateVersion = "24.05";
  };

  programs.starship.enable = true;
  programs.kitty.enable = true;

  vscode.enable = true;
  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config.allowUnfree = true;
  };
}
