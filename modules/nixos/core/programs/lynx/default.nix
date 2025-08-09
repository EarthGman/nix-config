{
  pkgs,
  lib,
  config,
  ...
}:
let
  program-name = "lynx";
  cfg = config.programs.${program-name};
in
{
  options.programs.${program-name} = lib.mkProgramOption {
    programName = program-name;
    description = "a TUI web browser";
    inherit pkgs;
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };
}
