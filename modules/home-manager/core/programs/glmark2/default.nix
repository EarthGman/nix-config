{
  lib,
  config,
  ...
}:
let
  program-name = "glmark2";
  cfg = config.programs.${program-name};
in
{
  config = lib.mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
