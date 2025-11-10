{
  pkgs,
  lib,
  config,
  ...
}:
let
  program-name = "rmpc";
  cfg = config.programs.${program-name};
in
{
  options.programs.${program-name} = lib.mkProgramOption {
    description = "rusty music player";
    programName = program-name;
    packageName = program-name;
    inherit pkgs;
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      cfg.package
    ];
    services.mpd.enable = true;
  };
}
