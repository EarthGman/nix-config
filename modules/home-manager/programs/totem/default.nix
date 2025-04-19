{ lib, config, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.totem;
in
{
  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
