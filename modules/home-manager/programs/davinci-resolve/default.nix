{ config, lib, ... }@args:
let
  icons = if args ? icons then args.icons else null;
  inherit (lib) mkIf getExe;
  cfg = config.programs.davinci-resolve;
in
{
  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];

    # for some reason the default derivation lacks a desktop file
    xdg.dataFile."applications/davinci-resolve.desktop" = mkIf (icons != null) {
      enable = true;
      text = ''
        [Desktop Entry]
        Name=Davinci Resolve
        Comment=Professional Video Editing
        Icon=${builtins.fetchurl icons.davinci-resolve}
        Exec=${getExe cfg.package}
        Terminal=false
        Type=Application
        Categories=Video
      '';
    };
  };
}
