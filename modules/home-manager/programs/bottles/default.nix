{ config, lib, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.bottles;
in

{
  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
