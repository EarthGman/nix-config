{ icons, pkgs, config, lib, ... }:
{
  options.custom.davinci-resolve.enable = lib.mkEnableOption "enable davinci-resolve";
  config = lib.mkIf config.custom.davinci-resolve.enable {
    home.packages = with pkgs; [
      davinci-resolve
    ];
    # for some reason the default derivation lacks a desktop file
    xdg.dataFile."applications/davinci-resolve.desktop" = {
      enable = true;
      text = ''
        [Desktop Entry]
        Name=Davinci Resolve
        Comment=Professional Video Editing
        Icon=${builtins.fetchurl icons.davinci-resolve}
        Exec=${lib.getExe pkgs.davinci-resolve}
        Terminal=false
        Type=Application
        Categories=Video
      '';
    };
  };
}
