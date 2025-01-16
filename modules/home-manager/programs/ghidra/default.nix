{ pkgs, lib, config, ... }:
{
  options.programs.ghidra.enable = lib.mkEnableOption "enable ghidra a set of software reverse engineering tools";
  config = lib.mkIf config.programs.ghidra.enable {
    home.packages = [ pkgs.ghidra ];
    home.sessionVariables = {
      "_JAVA_AWT_WM_NONREPARENTING" = "1";
    };
  };
}
