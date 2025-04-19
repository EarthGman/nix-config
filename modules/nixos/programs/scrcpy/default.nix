{ lib, config, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.scrcpy;
in
{
  config = mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };
}
