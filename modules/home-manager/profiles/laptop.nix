{ lib, config, ... }:
let
  inherit (lib) mkEnableOption mkIf mkDefault;
  cfg = config.profiles.laptop;
in
{
  options.profiles.laptop.enable = mkEnableOption "laptop profile for HM";
  config = mkIf cfg.enable {
    services.batsignal = {
      enable = true;
    };
    xsession.screensaver.enable = true;
    services = {
      # 30 minutes
      swayidle.suspend.timeout = mkDefault 1800;
      hypridle.suspend.timeout = mkDefault 1800;
    };
  };
}
