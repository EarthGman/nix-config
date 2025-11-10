{
  lib,
  config,
  ...
}:
let
  program-name = "gnome-system-monitor";
  cfg = config.programs.${program-name};
in
{
  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      cfg.package
    ];
  };
}
