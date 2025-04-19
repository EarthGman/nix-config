{ config, lib, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.musescore;
in
{
  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
