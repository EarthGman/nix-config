{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (lib) mkIf mkProgramOption;
  cfg = config.programs.fastfetch;
in
{
  options.programs.fastfetch = mkProgramOption {
    programName = "fastfetch";
    description = "fastfetch";
    inherit pkgs;
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };
}
