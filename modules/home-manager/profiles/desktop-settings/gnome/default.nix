{ pkgs, lib, config, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.profiles.gnome.default;
in
{
  options = {
    modules.desktops.gnome.enable = mkEnableOption "enable gnome module";
    profiles.gnome.default.enable = mkEnableOption "gnome desktop configuration";
  };
  config = mkIf (cfg.enable && config.modules.desktops.gnome.enable) {
    dconf.settings = import ./dconf.nix;
    programs.ghostty.settings.gtk-titlebar = true;
    home.packages = (with pkgs.gnomeExtensions; [
      dash-to-panel
      vitals
      arcmenu
    ]) ++ (with pkgs; [
      dconf2nix
      gnome-tweaks
      dconf-editor
    ]);
  };
}
