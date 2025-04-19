{ config, lib, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.cmatrix;
in
{
  config = mkIf cfg.enable {
    environment.systemPackages = [
      cfg.package
    ];
  };
}
