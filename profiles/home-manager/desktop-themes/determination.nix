{ pkgs, lib, wallpapers, icons, ... }:
let
  inherit (lib) mkForce;
  inherit (builtins) fetchurl;
in
{
  stylix.image = fetchurl wallpapers.home;
  stylix.colorScheme = "faraway";

  programs = {
    #tobyfox
    firefox.theme.name = "shyfox";
    firefox.theme.config.wallpaper = fetchurl wallpapers.mt-ebott-alt;
    vscode.userSettings = {
      editor = {
        "fontFamily" = mkForce "'OMORI_GAME'";
        "fontSize" = mkForce "32";
      };
      window = {
        "zoomLevel" = mkForce 1;
      };
    };

    fastfetch = {
      settings.logo = {
        height = 15;
        width = 36;
      };
      imageRandomizer = {
        enable = true;
        images = with icons; [
          (fetchurl heart-red)
          (fetchurl heart-blue)
          (fetchurl heart-orange)
          (fetchurl heart-pink)
          (fetchurl heart-green)
          (fetchurl heart-yellow)
          (fetchurl heart-teal)
        ];
      };
    };
  };
  stylix.fonts = {
    sansSerif = {
      name = "8\-bit Operator+";
      package = pkgs."8-bit-operator-font";
    };
    serif = {
      name = "8\-bit Operator+";
      package = pkgs."8-bit-operator-font";
    };
    monospace = {
      name = "8\-bit Operator+";
      package = pkgs."8-bit-operator-font";
    };
    emoji = {
      name = "8\-bit Operator+";
      package = pkgs."8-bit-operator-font";
    };

    sizes = {
      applications = 12;
      desktop = 12;
      popups = 10;
      terminal = 16;
    };
  };
}
