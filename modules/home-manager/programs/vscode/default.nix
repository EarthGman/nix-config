{ pkgs, lib, ... }:
let
  inherit (lib) mkDefault;
in
{
  programs.vscode = {
    package = mkDefault pkgs.master.vscodium-fhs;
    enableExtensionUpdateCheck = false;
    enableUpdateCheck = false;
    extensions = import ./extensions.nix { inherit pkgs; };
    userSettings = import ./settings.nix { inherit pkgs lib; };
  };
}
