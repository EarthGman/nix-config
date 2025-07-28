{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (lib)
    mkDefault
    mkForce
    mkEnableOption
    mkIf
    ;
  cfg = config.programs.vscode;
in
{
  options.programs.vscode.imperativeConfig = mkEnableOption "imperative configuration for vscode";
  config = {
    programs.vscode = {
      package = mkDefault pkgs.vscodium-fhs;
      profiles.default =
        if cfg.imperativeConfig then
          mkForce { }
        else
          {
            enableExtensionUpdateCheck = false;
            enableUpdateCheck = false;
          };
    };
  };
}
