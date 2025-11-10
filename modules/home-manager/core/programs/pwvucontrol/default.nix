{ config, lib, ... }:
let
  program-name = "pwvucontrol";
  cfg = config.programs.${program-name};
in
{
  config = lib.mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
