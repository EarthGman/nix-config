{ lib, config, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.ryujinx;
in
{
  config = mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };
}
