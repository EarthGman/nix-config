{
  pkgs,
  lib,
  config,
  ...
}:
let
  program-name = "davinci-resolve";
  cfg = config.programs.${program-name};
in
{
  config = lib.mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];

    xdg.dataFile."applications/davinci-resolve.desktop" = {
      text = ''
        [Desktop Entry]
        Name=Davinci Resolve
        Comment=Professional Video Editing
        Icon=${pkgs.images.davinci-resolve}
        Exec=${lib.getExe cfg.package}
        Terminal=false
        Type=Application
        Categories=Video
      '';
    };
  };
}
