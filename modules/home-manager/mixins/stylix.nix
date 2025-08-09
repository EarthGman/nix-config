{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.gman.stylix.enable = lib.mkEnableOption "gman's stylix configuration";

  config = lib.mkIf config.gman.stylix.enable {
    stylix = {
      enable = true;

      autoEnable = false;
      targets = {
        bat.enable = lib.mkDefault true;
        gnome.enable = lib.mkDefault true;
        gtk.enable = lib.mkDefault true;
        qt = {
          enable = lib.mkDefault true;
          platform = lib.mkOverride 800 "adwaita";
        };
        starship.enable = lib.mkDefault true;
        vesktop.enable = lib.mkDefault true;
      };

      cursor = {
        package = lib.mkDefault pkgs.bibata-cursors;
        name = lib.mkDefault "Bibata-Modern-Classic";
        size = lib.mkDefault 24;
      };

      iconTheme = {
        enable = lib.mkDefault true;
        dark = lib.mkDefault "Adwaita";
        light = lib.mkDefault "Adwaita";
        package = lib.mkDefault pkgs.adwaita-icon-theme;
      };

      opacity = {
        terminal = lib.mkOverride 800 0.87;
      };

      fonts = {
        sizes = {
          applications = lib.mkOverride 800 12;
          desktop = lib.mkOverride 800 14;
          popups = lib.mkOverride 800 12;
          terminal = lib.mkOverride 800 14;
        };
        sansSerif = lib.mkOverride 800 {
          name = "MesloLGS Nerd Font";
          package = pkgs.nerd-fonts.meslo-lg;
        };
        serif = lib.mkOverride 800 {
          name = "MesloLGS Nerd Font";
          package = pkgs.nerd-fonts.meslo-lg;
        };
        monospace = lib.mkOverride 800 {
          name = "MesloLGS Nerd Font";
          package = pkgs.nerd-fonts.meslo-lg;
        };
        emoji = lib.mkOverride 800 {
          name = "MesloLGS Nerd Font";
          package = pkgs.nerd-fonts.meslo-lg;
        };
      };
    };
  };
}
