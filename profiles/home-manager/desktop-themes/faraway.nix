{ pkgs, lib, wallpapers, icons, ... }:
let
  inherit (builtins) fetchurl;
  inherit (lib) mkForce;
in
{
  programs = {
    firefox.theme.name = "shyfox";
    firefox.theme.config.wallpaper = fetchurl wallpapers.a-home-for-flowers;
    fastfetch.image = fetchurl icons.oops;
    waybar = {
      theme = "faraway";
      bottomBar.settings = {
        "cpu".format = mkForce "  {usage}%";
        "memory".format = mkForce "  {percentage}%";
        "disk".format = mkForce "  {percentage_used}%";
        "clock".format = mkForce "  {:%R   %m.%d.%Y}";
        "pulseaudio".format = mkForce "{icon}  {volume}%";
      };
    };
    vscode.userSettings = {
      editor = {
        "fontFamily" = "'OMORI_GAME' ";
        "fontSize" = " 32 ";
      };
      window = {
        "zoomLevel" = 1;
      };
    };
  };

  services.omori-calendar-project.enable = true;

  stylix.colorScheme = "faraway";

  stylix.fonts = {
    sansSerif = {
      name = "OMORI_GAME";
      package = pkgs.omori-font;
    };
    serif = {
      name = "OMORI_GAME";
      package = pkgs.omori-font;
    };
    monospace = {
      name = "OMORI_GAME";
      package = pkgs.omori-font;
    };
    emoji = {
      name = "OMORI_GAME";
      package = pkgs.omori-font;
    };
    sizes = {
      applications = 24;
      desktop = 18;
      popups = 16;
      terminal = 14;
    };
  };
}


