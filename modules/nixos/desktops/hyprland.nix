{ pkgs, lib, config, ... }:
let
  cfg = config.modules.desktops.hyprland;
in
{
  options.modules.desktops.hyprland.enable = lib.mkEnableOption "enable hyprland module";
  config = lib.mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      withUWSM = true;
    };
    environment = {
      systemPackages = [ pkgs.wl-clipboard ];
      sessionVariables = {
        WLR_NO_HARDWARE_CURSORS = "1";
        # NIXOS_OZONE_WL = "1";
      };
    };
  };
}
