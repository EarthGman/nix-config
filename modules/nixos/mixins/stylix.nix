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
      autoEnable = lib.mkDefault false;

      targets = {
        qt = {
          enable = lib.mkDefault true;
          platform = lib.mkDefault "adwaita";
        };

        gnome.enable = lib.mkDefault true;
        gnome-text-editor.enable = lib.mkDefault true;
        gtk.enable = lib.mkDefault true;
      };

      cursor = {
        package = lib.mkDefault pkgs.bibata-cursors;
        name = lib.mkDefault "Bibata-Modern-Classic";
        size = lib.mkDefault 24;
      };
    };
  };
}
