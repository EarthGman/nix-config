{ pkgs, lib, config, ... }:
let
  inherit (lib) mkDefault mkEnableOption mkIf;
in
{
  options.vscode.enable = mkEnableOption "enable vscode";
  config = mkIf config.vscode.enable {
    programs.vscode = {
      package = mkDefault pkgs.master.vscodium-fhs;
      enable = true;
      enableExtensionUpdateCheck = false;
      enableUpdateCheck = false;
      extensions = import ./extensions.nix { inherit pkgs; };
      userSettings = import ./settings.nix { inherit pkgs; };
    };
  };
}
