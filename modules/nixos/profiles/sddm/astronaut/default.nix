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
  options.gman.profiles.sddm.astronaut.enable =
    lib.mkEnableOption "gman's sddm astronaut configuration";

  config = lib.mkIf cfg.enable {
    services.displayManager.sddm = {
      wayland.enable = true;
      theme = "sddm-astronaut-theme";
      themePackage = pkgs.sddm-astronaut.override {
        inherit (config.services.displayManager.sddm) themeConfig;
      };

      # astronaut requires sddm from plasma 6 (default is 5)
      package = pkgs.kdePackages.sddm;

      # why is this disabled by default?
      themeConfig = {
        AllowUppercaseLettersInUsernames = "true";
        FullBlur = "false";
        PartialBlur = "false";
      };
    };
  };
}
