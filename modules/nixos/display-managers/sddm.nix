{ pkgs, lib, config, desktop, ... }:
let
  cfg = config.services.displayManager.sddm;
  inherit (lib) types mkOption mkIf;
  desktops = lib.splitString "," desktop;
  preferredDesktop = builtins.elemAt desktops 0;

  # handle some weird edge cases with session names
  defaultSession =
    if (preferredDesktop == "i3")
    then
      "none+i3"
    else
      preferredDesktop;
in
{
  options = {
    modules.display-managers.sddm.enable = lib.mkEnableOption "enable sddm module";
    services.displayManager.sddm.themeConfig = mkOption {
      description = "sddm theme configuration written to theme.conf.user";
      type = types.attrsOf types.str;
      default = { };
    };
    services.displayManager.sddm.themeName = mkOption {
      description = "name of sddm theme to use. Must match file name in /pkgs/themes/sddm exactly without .nix";
      type = types.str;
      default = "astronaut";
    };
  };
  config =
    let
      themePackage = pkgs."${cfg.themeName}".override {
        inherit (cfg) themeConfig;
      };
    in
    mkIf config.modules.display-managers.sddm.enable {
      services.displayManager = {
        inherit defaultSession;
        sddm = {
          enable = true;
          package = pkgs.kdePackages.sddm;
          wayland.enable = true;
          # so sddm can use the dependencies in build inputs
          extraPackages = [ themePackage ];
          # specificies the theme folder in path /run/current-system/sw/share/sddm/themes
          theme = "${cfg.themeName}";
        };
      };
      # actually places the theme in the /run/current-system
      environment.systemPackages = [
        themePackage
      ];
    };
}
