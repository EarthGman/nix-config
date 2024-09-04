{ pkgs, lib, config, ... }:
let
  cfg = config.services.displayManager.sddm;
  inherit (lib) types mkOption mkIf;
in
{
  options = {
    custom.sddm.enable = lib.mkEnableOption "enable sddm";
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
    mkIf config.custom.sddm.enable {
      services.displayManager.sddm = {
        enable = true;
        package = pkgs.kdePackages.sddm;
        wayland.enable = true;
        # so sddm can use the dependencies in build inputs
        extraPackages = [ themePackage ];
        # specificies the theme folder in path /run/current-system/sw/share/sddm/themes
        theme = "${cfg.themeName}";
      };
      # actually places the theme in the /run/current-system
      environment.systemPackages = [
        themePackage
      ];
    };
}
