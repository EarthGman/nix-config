{ pkgs, ... }:
{
  programs = {
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
      mangohud
      protonup
    ];
    sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "~/.steam/root/compatibilitytools.d";
    };
  };
}
