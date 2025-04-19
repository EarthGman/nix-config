{ lib, config, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.cbonsai;
in
{
  config = mkIf cfg.enable {
    environment.systemPackages = [
      cfg.package
    ];
  };
}
