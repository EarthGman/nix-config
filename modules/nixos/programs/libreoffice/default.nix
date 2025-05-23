{ config, lib, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.libreoffice;
in
{
  config = mkIf cfg.enable {
    environment.systemPackages = [
      cfg.package
    ];
  };
}
