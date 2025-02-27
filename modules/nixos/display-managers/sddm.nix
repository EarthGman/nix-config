{ pkgs, lib, config, desktop, ... }:
let
  cfg = config.services.displayManager.sddm;
  inherit (lib) types mkOption mkIf mkDefault;
  desktops = lib.splitString "," desktop;
  preferredDesktop = builtins.elemAt desktops 0;

  # handle some weird edge cases with session names
  defaultSession =
    if (preferredDesktop == "i3")
    then
      "none+i3"
    else if (preferredDesktop == "hyprland") then
      "hyprland-uwsm"
    else if (preferredDesktop == "sway") then
      "sway-uwsm"
    else
      preferredDesktop;
in
{
  options = {
    modules.display-managers.sddm.enable = lib.mkEnableOption "enable sddm module";
    services.displayManager.sddm = {
      themePackage = mkOption {
        description = "package for sddm theme";
        type = types.package;
        default = pkgs.sddm-astronaut.override { inherit (cfg) themeConfig; };
      };
      themeConfig = mkOption {
        description = "sddm theme configuration written to theme.conf.user";
        type = types.attrsOf types.str;
        default = { };
      };
    };
  };

  config = mkIf config.modules.display-managers.sddm.enable {
    services.displayManager = {
      inherit defaultSession;
      sddm = {
        enable = true;
        package = pkgs.kdePackages.sddm;
        wayland.enable = true;
        # so sddm can access extra dependencies needed
        extraPackages = [ cfg.themePackage ];
        theme = mkDefault "sddm-astronaut-theme"; # I hate this abstraction so much
      };
    };
    # places theme in /run/current-system/sw/share/sddm/themes the name of sddm.theme must match the directory exactly
    environment.systemPackages = [ cfg.themePackage ];
  };
}
