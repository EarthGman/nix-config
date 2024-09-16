{ pkgs, lib, ... }:
let
  inherit (lib) mkDefault;
in
{
  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "SourceCodePro" ]; })
  ];
  programs.vscode = {
    package = mkDefault pkgs.master.vscodium-fhs;
    enableExtensionUpdateCheck = false;
    enableUpdateCheck = false;
    extensions = import ./extensions.nix { inherit pkgs; };
    userSettings = import ./settings.nix { inherit pkgs; };
  };
}
