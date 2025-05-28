{ pkgs, lib, config, ... }:
let
  inherit (lib) mkIf mkDefault;
in
{
  config = mkIf config.wayland.windowManager.sway.enable {
    home.packages = with pkgs; [
      wl-clipboard
    ];

    home.sessionVariables = {
      "_JAVA_AWT_WM_NONREPARENTING" = mkDefault "1"; # fix white screen bug for ghidra on sway
      # https://github.com/swaywm/sway/issues/5101
      "WLR_DRM_NO_MODIFIERS" = "1";
    };

    wayland.windowManager.sway.config.startup = mkIf config.services.hypridle.enable
      [
        {
          command = "systemctl --user stop hypridle";
        }
      ];
  };

}
