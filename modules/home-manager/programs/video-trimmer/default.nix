{ lib, config, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.video-trimmer;
in
{
  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
