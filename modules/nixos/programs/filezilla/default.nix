{ config, lib, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.filezilla;
in
{
  config = mkIf cfg.enable {
    environment.systemPackages = [
      cfg.package
    ];
  };
}
