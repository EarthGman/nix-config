{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.gman.profiles.sddm.astronaut;
in
{
  options.gman.profiles.sddm.astronaut = {
    enable = lib.mkEnableOption "gman's sddm astronaut configuration";
    config = {
      themeConfig = lib.mkOption {
        description = "theme configuration for sddm astronaut theme";
        type = lib.types.attrsOf lib.types.str;
        default = { };
      };
      embeddedTheme = lib.mkOption {
        description = "which embedded theme to use from the sddm-astronaut-theme repository";
        type = lib.types.str;
        default = "astronaut";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    services.displayManager.sddm = {
      wayland.enable = true;
      theme = "sddm-astronaut-theme";
      themePackage = pkgs.sddm-astronaut.override {
        inherit (cfg.config) themeConfig embeddedTheme;
      };

      # astronaut requires sddm from plasma 6 (default is 5)
      package = pkgs.kdePackages.sddm;
    };

    gman.profiles.sddm.astronaut.config.themeConfig = {
      # why is this disabled by default?
      AllowUppercaseLettersInUsernames = "true";

      FullBlur = "false";
      PartialBlur = "false";
    };
  };
}
