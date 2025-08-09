{
  lib,
  config,
  ...
}:
let
  program-name = "gthumb";
  cfg = config.programs.${program-name};
in
{
  config = lib.mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
