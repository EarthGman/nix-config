# small wrapper to make sddm config more intuative
{ lib, config, ... }:
let
  cfg = config.services.displayManager.sddm;
in
{
  options.services.displayManager.sddm = {
    themePackage = lib.mkOption {
      description = "package for sddm theme";
      type = lib.types.package;
      default = null;
    };
  };

  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      (lib.mkIf (cfg.themePackage != null) {
        services.displayManager.sddm.extraPackages = [ cfg.themePackage ];
        environment.systemPackages = [ cfg.themePackage ];
      })
    ]
  );
}
