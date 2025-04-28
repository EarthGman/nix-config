{ lib, config, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.ryujinx;
in
{
  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}
