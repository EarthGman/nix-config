{ inputs, outputs, pkgs, config, lib, ... }:
let
  inherit (lib) mkOption mkIf mkDefault types;
  cfg = config.stylix;
in
{
  imports = [
    inputs.stylix.homeManagerModules.stylix
  ];
  options = {
    stylix.colorScheme = mkOption {
      description = ''
        name of the .yaml file under ./color-palettes (excluding .yaml)
        used to convert a simple string into a path for easier config management
      '';
      type = types.str;
      default = "ashes";
    };
  };
  config = {
    stylix = {
      enable = mkDefault true;
      image = mkDefault outputs.wallpapers.default;
      base16Scheme = mkIf (cfg.colorScheme != "") (./. + "/color-palettes/${cfg.colorScheme}.yaml");

      targets = mkDefault {
        vscode.enable = false;
      };

      cursor = mkDefault {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Classic";
        size = 24;
      };

      fonts = mkDefault {
        serif = {
          package = pkgs.dejavu_fonts;
          name = "DejaVu Sans";
        };
        sansSerif = {
          package = pkgs.dejavu_fonts;
          name = "DejaVu Sans";
        };
        monospace = {
          package = pkgs.dejavu_fonts;
          name = "DejaVu Sans Mono";
        };
        emoji = {
          package = pkgs.noto-fonts-emoji;
          name = "Noto Color Emoji";
        };
      };
    };
  };
}
