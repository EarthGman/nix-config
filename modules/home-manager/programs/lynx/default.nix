{ pkgs, lib, config, ... }:
let
  inherit (lib) mkProgramOption mkIf;
  program-name = "lynx";
  cfg = config.programs.${program-name};
in
{
  options.programs.${program-name} = mkProgramOption {
    programName = program-name;
    description = "lynx, TUI web browser";
    inherit pkgs;
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}
