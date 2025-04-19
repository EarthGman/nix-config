{ config, lib, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.dosbox;
in
{
  config = mkIf cfg.enable {
    environment.systemPackages = [
      cfg.package
    ];
  };
}
