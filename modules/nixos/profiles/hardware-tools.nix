{ pkgs, lib, config, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.profiles.hardware-tools;
in
{
  options.profiles.hardware-tools.enable = mkEnableOption "various hardware diagnostic tools";
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      usbutils
      pciutils
      lshw
      inxi
    ];
  };
}
