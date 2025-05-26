{ config, lib, ... }:
let
  inherit (lib) mkIf;
  cfg = config.services.mpd;
in
{
  home.sessionVariables = mkIf cfg.enable {
    "MPD_HOST" = "/tmp/mpd_socket";
  };

  services.mpd = {
    enable = config.programs.rmpc.enable;
    network = {
      listenAddress = "/tmp/mpd_socket";
    };
    extraConfig = ''
      audio_output {
        type            "pipewire"
        name            "PipeWire Sound Server"
      }
    '';
  };
}
