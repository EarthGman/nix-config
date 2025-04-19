{ config, lib, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.gcolor;
in
{
  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
