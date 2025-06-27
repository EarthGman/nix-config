{ lib, config, ... }:
let
  cfg = config.services.displayManager.sddm;
  inherit (lib) types mkOption mkIf;
in
{
  options = {
    services.displayManager.sddm = {
      themePackage = mkOption {
        description = "package for sddm theme";
        type = types.package;
        default = null;
      };
      themeConfig = mkOption {
        description = "sddm theme configuration written to theme.conf.user";
        type = types.attrsOf types.str;
        default = { };
      };
    };
  };

  config = {
    # places theme in /run/current-system/sw/share/sddm/themes the name of sddm.theme must match the directory exactly
    environment.systemPackages = mkIf (cfg.themePackage != null) [ cfg.themePackage ];
  };
}
