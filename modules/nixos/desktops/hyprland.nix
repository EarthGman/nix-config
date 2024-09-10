{ lib, config, ... }:
{
  options.custom.hyprland.enable = lib.mkEnableOption "enable hyprland module";
  config = lib.mkIf config.custom.hyprland.enable {
    programs.hyprland = {
      enable = true;
    };

    environment.sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1";
      # NIXOS_OZONE_WL = "1";
    };
  };
  NIXOS_OZONE_WL = "1";
}
