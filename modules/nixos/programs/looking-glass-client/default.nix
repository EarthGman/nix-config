{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (lib) mkProgramOption mkIf;
  cfg = config.programs.looking-glass-client;
in
{
  options.programs.looking-glass-client = mkProgramOption {
    programName = "looking-glass-client";
    inherit pkgs;
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };
}
