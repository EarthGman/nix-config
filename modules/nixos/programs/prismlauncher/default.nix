{ config, lib, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.prismlauncher;
in
{
  config = mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };
}
