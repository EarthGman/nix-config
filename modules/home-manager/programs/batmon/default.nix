{ config, lib, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.batmon;
in

{
  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
