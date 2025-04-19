{ lib, config, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.xclicker;
in
{
  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
