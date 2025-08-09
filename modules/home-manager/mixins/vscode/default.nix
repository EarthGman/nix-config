{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.gman.vscode;
in
{
  options.gman.vscode.enable = lib.mkEnableOption "gman's vscode configuration";

  config = lib.mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium-fhs;
      profiles.default = {
        extensions = import ./extensions.nix { inherit pkgs; };
        userSettings = import ./settings.nix { inherit pkgs lib; };
      };
    };
  };
}
