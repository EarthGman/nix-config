{ config, lib, ... }:
let
  inherit (lib) mkDefault;
in
{
  options.custom = {
    sound.enable = lib.mkEnableOption "enable sound with pipewire";
  };
  config = lib.mkIf config.custom.sound.enable {
    hardware = {
      pulseaudio.enable = false;
      bluetooth.enable = mkDefault true;
    };
    # pulse needs this
    security.rtkit.enable = true;
    services = {
      blueman.enable = mkDefault true;
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
