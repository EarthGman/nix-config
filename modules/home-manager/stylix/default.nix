{ inputs, wallpapers, pkgs, config, lib, ... }:
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
      image = mkDefault wallpapers.default;
      base16Scheme = mkIf (cfg.colorScheme != "") (./. + "/color-palettes/${cfg.colorScheme}.yaml");

      targets = {
        vscode.enable = mkDefault false;
      };

      cursor = {
        package = mkDefault pkgs.bibata-cursors;
        name = mkDefault "Bibata-Modern-Classic";
        size = mkDefault 24;
      };

      fonts = {
        sizes = {
          applications = mkDefault 12;
          desktop = mkDefault 12;
          popups = mkDefault 10;
          terminal = mkDefault 14;
        };
      };
    };
  };
}
