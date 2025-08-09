{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.gman.rmpc.enable = lib.mkEnableOption "gman's rmpc configuration";

  config = lib.mkIf config.gman.rmpc.enable {
    warnings = lib.mkIf (!pkgs.stdenv.isLinux) [
      ''
        my rmpc module is configured to work with pipewire on linux.
        it will not work properly on MacOS, and mpd will have to reconfigured.
      ''
    ];
    home.packages = [ pkgs.yt-dlp ];

    programs.rmpc = {
      enable = true;
      config = builtins.readFile ./config.ron;
      imperativeConfig = false;
    };

    xdg.configFile."rmpc/themes/default.ron" = {
      text = builtins.readFile ./theme.ron;
    };

    home.sessionVariables = {
      "MPD_HOST" = config.services.mpd.network.listenAddress;
      "MPD_PORT" = config.services.mpd.network.port;
    };

    services.mpd = {
      enable = true;
      musicDirectory = lib.mkDefault config.xdg.userDirs.music;
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
  };
}
