{ self, pkgs, config, lib, ... }:
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
        Icon=${self}/icons/davinci-resolve.png
        Exec=${pkgs.davinci-resolve}/bin/davinci-resolve
        Terminal=false
        Type=Application
        Categories=Video
      '';
    };
  };
}
