{ inputs, pkgs, config, lib, ... }:
let
  inherit (lib) mkDefault mkIf mkForce;
  cfg = config.modules.pipewire;
in
{
  imports = [ inputs.nix-gaming.nixosModules.pipewireLowLatency ];
  options.modules.pipewire.enable = lib.mkEnableOption "enable sound with pipewire";
  config = mkIf cfg.enable {
    security.rtkit.enable = true; # hands out realtime scheduling priority to user processes on demand. Improves performance of pulse

    # additional utilities
    environment.systemPackages = with pkgs; [
      easyeffects
      helvum
    ];
    services = {
      pipewire = {
        # enables alsa, pulseaudio, and jack support by default
        enable = true;
        alsa.enable = mkDefault true;
        alsa.support32Bit = mkDefault true;
        pulse.enable = mkDefault true;
        jack.enable = mkDefault true;

        lowLatency = {
          enable = true;
        };
      };
    };
  };
}
