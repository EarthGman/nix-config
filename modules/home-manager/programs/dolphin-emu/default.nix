{ config, lib, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.dolphin-emu;
in
{
  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}

