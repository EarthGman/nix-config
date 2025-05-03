{ inputs, config, lib, ... }@args:
let
  inherit (lib) mkDefault mkIf;
  cfg = config.modules.pipewire;
  desktop = if args ? desktop then args.desktop else null;
in
{
  imports = [ inputs.nix-gaming.nixosModules.pipewireLowLatency ];
  options.modules.pipewire.enable = lib.mkEnableOption "enable sound with pipewire";
  config = mkIf cfg.enable {
    security.rtkit.enable = true; # hands out realtime scheduling priority to user processes on demand. Improves performance of pulse

    # additional utilities
    programs = {
      helvum.enable = mkDefault (desktop != null);
      easyeffects.enable = mkDefault (desktop != null);
    };

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
