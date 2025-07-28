{
  pkgs,
  config,
  lib,
  ...
}:
let
  inherit (lib) mkIf mkProgramOption;
  cfg = config.programs.evince;
in
{
  options.programs.evince = mkProgramOption {
    programName = "evince";
    description = "PDF viewer for GNOME";
    inherit pkgs;
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
