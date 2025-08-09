{
  lib,
  config,
  ...
}:
let
  program-name = "gscan2pdf";
  cfg = config.programs.${program-name};
in
{
  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      cfg.package
    ];
  };
}
