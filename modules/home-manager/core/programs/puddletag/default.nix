{
  lib,
  config,
  ...
}:
let
  program-name = "puddletag";
  cfg = config.programs.${program-name};
in
{
  config = lib.mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
