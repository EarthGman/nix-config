{ config, lib, ... }:
let
  inherit (lib) mkDefault mkIf;
  cfg = config.modules.pipewire;
in
{
  options.modules.pipewire.enable = lib.mkEnableOption "enable sound with pipewire";
  config = mkIf cfg.enable {
    hardware = {
      pulseaudio.enable = false;
    };
    # pulse needs this
    security.rtkit.enable = true;
    services = {
      pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = mkDefault true;
        # enables pipewire pulse
        pulse.enable = true;
      };
    };
  };
}
