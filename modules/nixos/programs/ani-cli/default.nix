{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (lib) mkIf;
  cfg = config.programs.ani-cli;
in
{
  config = mkIf cfg.enable {
    environment.systemPackages = [
      cfg.package
      pkgs.ani-skip
    ];
  };
}
