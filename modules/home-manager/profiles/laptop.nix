{ lib, config, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.profiles.laptop;
in
{
  options.profiles.laptop.enable = mkEnableOption "laptop profile for HM";
  config = mkIf cfg.enable {
    services.batsignal = {
      enable = true;
    };
    xsession.screensaver.enable = true;
  };
}
