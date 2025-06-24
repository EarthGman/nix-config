{ pkgs, lib, config, ... }@args:
# does not provide game files, they must be installed already
let
  icons = if args ? icons then args.icons else null;
  inherit (lib) mkEnableOption mkOption types mkIf getExe;
  inherit (builtins) toPath;
  cfg = config.programs.ygo-omega;
  home = config.home.homeDirectory;
  launch = "${getExe pkgs.steam-run} ${cfg.gameFileDir}/OmegaUpdater";
in
{
  options.programs.ygo-omega = {
    enable = mkEnableOption ''
      the desktop shortcut for ygo-omega
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
    xdg.dataFile."applications/ygo-omega.desktop" = mkIf (icons != null) {
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
