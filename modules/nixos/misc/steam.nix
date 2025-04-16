{ pkgs, lib, config, ... }:
let
  inherit (lib) mkEnableOption mkIf mkDefault;
  cfg = config.modules.steam;
in
{
  options.modules.steam.enable = mkEnableOption "enable steam module";
  config = mkIf cfg.enable {
    programs = {
      mangohud.enable = mkDefault true;
      gamemode.enable = true;
      steam = {
        enable = true;
        gamescopeSession = {
          enable = true;
        };
      };
    };
    environment = {
      systemPackages = with pkgs; [
        protonup
      ];
      sessionVariables = {
        STEAM_EXTRA_COMPAT_TOOLS_PATHS = "~/.steam/root/compatibilitytools.d";
      };
    };
  };
}
