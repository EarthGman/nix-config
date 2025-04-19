{ lib, config, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.vlc;
in
{
  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
