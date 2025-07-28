{ lib, config, ... }:
let
  inherit (lib)
    mkDefault
    mkIf
    mkEnableOption
    mkForce
    ;
  cfg = config.profiles.laptop;
in
{
  options.profiles.laptop.enable = mkEnableOption "laptop profile";
  config = mkIf cfg.enable {
    programs.batmon.enable = mkDefault true;

    services.power-profiles-daemon.enable = mkForce false;
    services.tlp = {
      enable = mkDefault true;
      settings = {
        CPU_SCALING_GOVERNER_ON_AC = "performance";
        CPU_SCALING_GOVERNER_ON_BAT = "powersave";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;
        CPU_HWP_DYN_BOOST_ON_AC = 1;
        CPU_HWP_DYN_BOOST_ON_BAT = 0;
        DEVICES_TO_DISABLE_ON_BAT_NOT_IN_USE = "bluetooth";
      };
    };
  };
}
