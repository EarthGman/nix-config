{
  lib,
  config,
  ...
}:
let
  program-name = "dolphin-emu";
  cfg = config.programs.${program-name};
in
{
  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      cfg.package
    ];
    services.udev.packages = [
      cfg.package
    ];
  };
}
