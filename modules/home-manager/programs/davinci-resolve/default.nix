{ icons, pkgs, config, lib, ... }:
let
  inherit (lib) mkIf mkEnableOption mkOption types;
  cfg = config.programs.davinci-resolve;
in
{
  options.programs.davinci-resolve = {
    enable = mkEnableOption "enable davinci-resolve, a paid professional video editor that works on linux";

    package = mkOption {
      description = "package for davinci-resolve";
      type = types.package;
      default = pkgs.davinci-resolve;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];

    # for some reason the default derivation lacks a desktop file
    xdg.dataFile."applications/davinci-resolve.desktop" = {
      enable = true;
      text = ''
        [Desktop Entry]
        Name=Davinci Resolve
        Comment=Professional Video Editing
        Icon=${builtins.fetchurl icons.davinci-resolve}
        Exec=${lib.getExe cfg.package}
        Terminal=false
        Type=Application
        Categories=Video
      '';
    };
  };
}
