{ config, lib, ... }:
let
  inherit (lib) mkIf mkDefault;
  cfg = config.services.mpd;
in
{
  # these aren't included by default in the home-manager module and are needed by programs.rmpc
  home.sessionVariables = mkIf cfg.enable {
    "MPD_HOST" = cfg.network.listenAddress;
    "MPD_PORT" = cfg.network.port;
  };

  services.mpd = {
    enable = mkDefault config.programs.rmpc.enable;
    network = {
      listenAddress = "/tmp/mpd_socket";
    };
    extraConfig = ''
      audio_output {
        type "pipewire"
        name "PipeWire Sound Server"
      }
    '';
  };
}
