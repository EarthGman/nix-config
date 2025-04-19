{ pkgs, lib, config, ... }:
let
  inherit (lib) mkIf mkProgramOption;
  cfg = config.programs.ghidra;
in
{
  options.programs.ghidra = mkProgramOption {
    programName = "ghidra";
    description = "software reverse engineering suite written in java";
    inherit pkgs;
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
    home.sessionVariables = {
      "_JAVA_AWT_WM_NONREPARENTING" = "1"; # fix white screen bug on sway
    };
  };
}
