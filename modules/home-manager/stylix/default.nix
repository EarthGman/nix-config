{ inputs, pkgs, config, lib, ... }:
let
  inherit (lib) mkOption mkIf mkDefault types;
  cfg = config.stylix;
in
{
  imports = [
    inputs.stylix.homeModules.stylix
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
      # only allow stylix to manage what I tell it to
      autoEnable = mkDefault false;
      image = mkDefault config.custom.wallpaper;
      base16Scheme = mkIf (cfg.colorScheme != "") (./. + "/color-palettes/${cfg.colorScheme}.yaml");
      polarity = mkDefault "dark";

      targets =
        let
          enabled = { enable = mkDefault true; };
        in
        {
          # NOTE: gnome must be enabled for electron apps such as obsidian and 1password for example to properly follow stylix.polarity
          gnome = enabled;
          bat = enabled;
          rofi = enabled;
          kitty = enabled;
          alacritty = enabled;
          dunst = enabled;
          wezterm = enabled;
          gtk = enabled;
          qt = enabled;
          yazi = enabled;
          starship = enabled;
          lazygit = enabled;
          i3 = enabled;
          sway = enabled;
          hyprland = enabled;
          vesktop = enabled;
          waybar = enabled;
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

      opacity = {
        terminal = mkDefault 0.87;
      };
    };
  };
}
