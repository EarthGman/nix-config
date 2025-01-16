{ pkgs, lib, config, icons, ... }:
# does not provide game files, they must be installed already
let
  inherit (lib) mkEnableOption mkOption types mkIf getExe;
  inherit (builtins) toPath;
  cfg = config.programs.ygo-omega;
  home = config.home.homeDirectory;
  launch = "${getExe pkgs.steam-run} ${cfg.gameFileDir}/OmegaUpdater";
in
{
  options.programs.ygo-omega = {
    enable = mkEnableOption ''
      enable ygo-omega desktop
      DOES NOT give you the game files
      extract the game files then 'steam-run ./YGO\ Omega.x86_64'
      the game will launch but will freeze
      close the game
      you will now have OmegaUpdater
      chmod +x OmegaUpdater and the game should launch from the icon
    '';
    gameFileDir = mkOption {
      description = ''
        path to the ygo omega game files
      '';
      type = types.path;
      default = toPath "${home}/games/ygo-omega";
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
  };
}
