{ pkgs, lib, config, ... }:
let
  inherit (lib) mkOption mkEnableOption mkIf types;
  cfg = config.programs.ghidra;
in
{
  options.programs.ghidra = {
    enable = mkEnableOption "enable ghidra a set of software reverse engineering tools";
    package = mkOption {
      description = "ghidra package";
      type = types.package;
      default = pkgs.stable.ghidra; # nixpkgs unstable fails to build 1-21-2025
    };
  };
  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
    home.sessionVariables = {
      "_JAVA_AWT_WM_NONREPARENTING" = "1"; # fix white screen bug on sway
    };
  };
}
