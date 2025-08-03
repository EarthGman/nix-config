{
  pkgs,
  config,
  lib,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkDefault
    types
    mkOption
    ;
  cfg = config.profiles.stylix.default;
in
{
  options.profiles.stylix.default = {
    enable = mkEnableOption "default stylix configuration";
    colorScheme = mkOption {
      description = ''
        name of the .yaml file under ./color-palettes (excluding .yaml)
        used to convert a simple string into a path for easier config management
      '';
      type = types.str;
      default = "ashes";
    };
  };
  config = mkIf cfg.enable {

    stylix = {
      polarity = mkDefault "dark";
      base16Scheme = mkIf (cfg.colorScheme != "") (
        ../../../stylix/color-palettes + "/${cfg.colorScheme}.yaml"
      );

      targets =
        let
          enabled = {
            enable = mkDefault true;
          };
        in
        {
          # NOTE: gnome must be enabled for electron apps such as obsidian and 1password to properly follow stylix.polarity
          gnome = enabled;
          gtk = enabled;
          qt = enabled;
          vesktop = enabled;
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
          desktop = mkDefault 14;
          popups = mkDefault 12;
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

      opacity = {
        terminal = mkDefault 0.87;
      };
    };
  };
}
