{ pkgs, lib, config, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.profiles.desktops.gnome.default;
in
{
  options.profiles.desktops.gnome.default.enable = mkEnableOption "gnome desktop configuration";
  config = mkIf cfg.enable {
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
