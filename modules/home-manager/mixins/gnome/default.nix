{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.gman.gnome;
in
{
  options = {
    gman.gnome = {
      enable = lib.mkEnableOption "gman's gnome configuration";
      config.withDconf = lib.mkOption {
        description = "whether to enable gman's declarative dconf for gnome";
        type = lib.types.bool;
        default = true;
      };
    };
  };
  config = lib.mkIf cfg.enable {
    dconf.settings = lib.mkIf cfg.config.withDconf (import ./dconf.nix);

    stylix.targets.qt.platform = "adwaita";

    # here are some extensions, go crazy
    home.packages =
      builtins.attrValues ({
        inherit (pkgs.gnomeExtensions)
          dash-to-panel
          vitals
          arcmenu
          ;
      })
      ++ (builtins.attrValues {
        inherit (pkgs)
          dconf2nix
          gnome-tweaks
          dconf-editor
          ;
      });
  };
}
