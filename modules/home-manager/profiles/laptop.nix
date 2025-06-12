{ lib, config, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.profiles.laptop;
in
{
  options.profiles.laptop.enable = mkEnableOption "laptop profile for HM";
  config = mkIf cfg.enable {
    # custom script that warns you when battery is low
    services.dunst.battery-monitor.enable = true;
    xsession.screensaver.enable = true;
  };
}
