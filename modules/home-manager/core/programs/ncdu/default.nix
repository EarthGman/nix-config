{
  pkgs,
  lib,
  config,
  ...
}:
let
  program-name = "ncdu";
  cfg = config.programs.${program-name};
in
{
  options.programs.${program-name} = lib.mkProgramOption {
    description = "find sizes of files";
    programName = program-name;
    packageName = program-name;
    inherit pkgs;
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
