{ pkgs, config, lib, ... }:
let
  inherit (lib) mkIf mkProgramOption;
  cfg = config.programs.obsidian;
in
{
  options.programs.obsidian = mkProgramOption {
    programName = "obsidian";
    description = "Note storage vault for .md";
    inherit pkgs;
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      cfg.package
    ];
  };
}
