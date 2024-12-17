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
      image = mkDefault (builtins.fetchurl wallpapers.default);
      base16Scheme = mkIf (cfg.colorScheme != "") (./. + "/color-palettes/${cfg.colorScheme}.yaml");
      polarity = mkDefault "dark";

      targets = {
        vscode.enable = mkDefault false;
      };

      cursor = {
        package = mkDefault pkgs.bibata-cursors;
        name = mkDefault "Bibata-Modern-Classic";
        size = mkDefault 24;
      };

      iconTheme = {
        enable = mkDefault true;
        dark = mkDefault "Adwaita";
        light = mkDefault "Adwaita";
        package = mkDefault pkgs.adwaita-icon-theme;
      };

      fonts = {
        sizes = {
          applications = mkDefault 12;
          desktop = mkDefault 12;
          popups = mkDefault 10;
          terminal = mkDefault 14;
        };
        sansSerif = mkDefault {
          name = "MesloLGS Nerd Font";
          package = pkgs.nerd-fonts.meslo-lg;
        };
        serif = mkDefault {
          name = "MesloLGS Nerd Font";
          package = pkgs.nerd-fonts.meslo-lg;
        };
        monospace = mkDefault {
          name = "MesloLGS Nerd Font";
          package = pkgs.nerd-fonts.meslo-lg;
        };
        emoji = mkDefault {
          name = "MesloLGS Nerd Font";
          package = pkgs.nerd-fonts.meslo-lg;
        };
      };
    };
  };
}
