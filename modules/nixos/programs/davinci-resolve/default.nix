{ config, lib, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.davinci-resolve;
in
{
  config = mkIf cfg.enable {
    environment.systemPackages = [
      cfg.package
    ];
  };
}
