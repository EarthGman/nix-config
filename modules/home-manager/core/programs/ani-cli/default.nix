{
  pkgs,
  lib,
  config,
  ...
}:
let
  program-name = "ani-cli";
  cfg = config.programs.${program-name};
in
{
  config = lib.mkIf cfg.enable {
    home.packages = [
      cfg.package
      pkgs.ani-skip
    ];
  };
}
