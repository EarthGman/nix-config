{ lib, config, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.autokey;
in
{
  config = mkIf cfg.enable {
    environment.systemPackages = [
      cfg.package
    ];
  };
}
