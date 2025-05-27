{ pkgs, lib, config, ... }:
let
  inherit (lib) mkIf;
in
{
  config = mkIf config.wayland.windowManager.sway.enable {
    home.packages = with pkgs; [
      wl-clipboard
      swayidle
    ];

    home.sessionVariables = {
      "_JAVA_AWT_WM_NONREPARENTING" = "1"; # fix white screen bug on sway
    };
  };

}
