{
  lib,
  config,
  ...
}:
let
  program-name = "protonup-qt";
  cfg = config.programs.${program-name};
in
{
  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      cfg.package
    ];
  };
}
