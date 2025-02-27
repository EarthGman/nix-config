{ pkgs, lib, config, ... }:
let
  inherit (lib) mkDefault mkEnableOption mkIf;
  cfg = config.programs.vscode;
in
{
  options.programs.vscode.imperativeConfig = mkEnableOption "imperative configuration for vscode";
  config = {
    programs.vscode = {
      package = mkDefault pkgs.vscodium-fhs;
      profiles.default = mkIf (!cfg.imperativeConfig) {
        enableExtensionUpdateCheck = false;
        enableUpdateCheck = false;
        extensions = import ./extensions.nix { inherit pkgs; };
        userSettings = import ./settings.nix { inherit pkgs lib; };
      };
    };
  };
}
