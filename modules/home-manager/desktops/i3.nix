{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (lib) mkIf mkDefault;
in
{
  config = mkIf config.xsession.windowManager.i3.enable {
    home.packages = with pkgs; [
      xclip
      xorg.xmodmap
    ];

    xsession.enable = true;
  };
}
