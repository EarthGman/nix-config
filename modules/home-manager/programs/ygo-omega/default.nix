{ pkgs, lib, config, icons, ... }:
# does not provide game files, they must be installed already
let
  inherit (lib) mkEnableOption mkOption types mkIf;
  inherit (builtins) toPath;
  cfg = config.custom.ygo-omega;
  home = config.home.homeDirectory;
  launch = "${pkgs.steam-run}/bin/steam-run ${cfg.gameFileDir}/OmegaUpdater";
in
{
  options.custom.ygo-omega = {
    enable = mkEnableOption "enable ygo-omega desktop";
    gameFileDir = mkOption {
      description = "path to the ygo omega game files";
      type = types.path;
      default = toPath "${home}/games/ygo-omega";
    };
    executablePath = mkOption {
      description = ''
        places a version of the launch script on your shell path
        set this option to the path where that executable will be stored
        default = ~/bin/ygo-omega
        make sure the directory is on your shell path
      '';
      type = types.path;
      default = toPath "${home}/bin";
    };
  };
  config = mkIf cfg.enable {
    xdg.dataFile."applications/ygo-omega.desktop" = {
      enable = true;
      text = ''
        [Desktop Entry]
        Name=YGO Omega
        Comment=Yugioh Simulator
        Icon=${builtins.fetchurl icons.ygo-omega}
        Exec=${launch}
        Terminal=false
        Type=Application
        Categories=Game
      '';
    };
    home.file = {
      "${cfg.executablePath}/ygo-omega" = {
        executable = true;
        text = ''
          #!/usr/bin/env bash
          ${launch}
        '';
      };
    };
  };
}
