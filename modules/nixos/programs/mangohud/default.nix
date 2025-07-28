{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (lib) mkIf mkProgramOption;
  cfg = config.programs.mangohud;
in
{
  options.programs.mangohud = mkProgramOption {
    programName = "mangohud";
    description = "monitoring overlay for games";
    inherit pkgs;
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };
}
