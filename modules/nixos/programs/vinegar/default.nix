{ pkgs, lib, config, ... }:
let
  inherit (lib) mkIf mkProgramOption;
  cfg = config.programs.vinegar;
in
{
  options.programs.vinegar = mkProgramOption {
    programName = "vinegar";
    description = "roblox studio for linux";
    inherit pkgs;
  };
  config = mkIf cfg.enable {
    environment.systemPackages = [ cfg.package pkgs.wine64 ];
  };
}
