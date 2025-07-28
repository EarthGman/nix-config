{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.profiles.vscode.default;
in
{
  options.profiles.vscode.default.enable = mkEnableOption "default vscode profile";

  config = mkIf cfg.enable {
    programs.vscode.profiles.default = {
      extensions = import ./extensions.nix { inherit pkgs; };
      userSettings = import ./settings.nix { inherit pkgs lib; };
    };
  };
}
