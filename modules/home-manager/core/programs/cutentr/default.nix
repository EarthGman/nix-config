{
  lib,
  config,
  ...
}:
let
  program-name = "cutentr";
  cfg = config.programs.${program-name};
in
{
  config = lib.mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
