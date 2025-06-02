{ lib, config, ... }:
let
  inherit (lib) mkIf;
  program-name = "dolphin";
  cfg = config.programs.${program-name};
in
{
  config = mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };
}
