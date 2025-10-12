{
  pkgs,
  lib,
  config,
  ...
}:
let
  program-name = "dolphin";
  cfg = config.programs.${program-name};
in
{
  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      cfg.package
      pkgs.kdePackages.kde-cli-tools
      pkgs.kdePackages.qtsvg
      pkgs.kdePackages.kio-fuse
      pkgs.kdePackages.kio-extras
    ];
  };
}
