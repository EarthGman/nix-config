{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (lib) mkIf mkProgramOption;
  cfg = config.programs.rmpc;
in
{
  options.programs.rmpc = mkProgramOption {
    programName = "rmpc";
    description = "terminal music player written in rust";
    inherit pkgs;
  };

  config = mkIf cfg.enable {
    services.mpd.enable = true;
    environment.systemPackages = [ cfg.package ];
  };
}
