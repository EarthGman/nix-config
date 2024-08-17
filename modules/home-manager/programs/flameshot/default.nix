{ pkgs, config, lib, ... }:
{
  options.flameshot.enable = lib.mkEnableOption "enable flameshot";
  config = lib.mkIf config.flameshot.enable {
    home.packages = with pkgs; [
      flameshot
    ];
    xdg.configFile = {
      "flameshot/flameshot.ini".text = lib.generators.toINI { } {
        General = {
          "contrastOpacity" = 188;
          "copyOnDoubleClick" = true;
          "drawColor" = "#fff600";
          "drawThickness" = 26;
          "saveAfterCopy" = true;
          "saveAsFileExtension" = "png";
          "savePath" = "${config.home.homeDirectory}/Pictures/Screenshots";
          "savePathFixed" = true;
          "showHelp" = true;
        };
      };
    };
  };
}
