{ lib, config, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.blender;
in
{
  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}
