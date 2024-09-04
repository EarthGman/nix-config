{ username, outputs, lib, stateVersion, ... }:
let
  programsDir = ./modules/home-manager/programs;
  programs = lib.forEach (builtins.attrNames (builtins.readDir programsDir)) (dirname: programsDir + /${dirname});
in
{
  programs.home-manager.enable = true;

  imports = programs;

  home = {
    inherit username stateVersion;
    homeDirectory = "/home/${username}";
  };

  programs.starship.enable = true;
  programs.kitty.enable = true;

  vscode.enable = true;
  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config.allowUnfree = true;
  };
}
