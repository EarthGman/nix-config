{ pkgs, config, lib, ... }:
let
  inherit (lib) mkIf getExe;
  cfg = config.programs.prismlauncher;
in
{
  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}
