{ pkgs, lib, config, ... }:
let
  inherit (lib) mkEnableOption mkDefault mkIf;
  cfg = config.profiles.sddm.default;
in

{
  options.profiles.sddm.default.enable = mkEnableOption "default sddm profile";
  config = mkIf cfg.enable {
    services.displayManager.sddm = {
      wayland.enable = true;
      theme = "sddm-astronaut-theme";
      themePackage = pkgs.sddm-astronaut.override {
        inherit (config.services.displayManager.sddm) themeConfig;
      };

      package = mkDefault pkgs.kdePackages.sddm;
      themeConfig = {
        AllowUppercaseLettersInUsernames = "true";
      };
    };
  };
}
