{ pkgs, lib, config, ... }:
let
  inherit (lib) mkProgramOption mkIf;
  cfg = config.programs.blender;
in
{
  config = mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };
}
