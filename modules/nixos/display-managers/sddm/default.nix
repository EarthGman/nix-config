{ pkgs, lib, config, displayManagerTheme, ... }:
let
  hasTheme = (displayManagerTheme != null);
in
{
  services.displayManager.sddm = {
    enable = true;
    theme = lib.mkIf (hasTheme) pkgs.sddmThemes.${displayManagerTheme};
  };

  # sddm theme dependencies
  environment.systemPackages = (with pkgs; [
    kconfig-frontends
  ]) ++ (with pkgs.libsForQt5; [
    karchive
    kcompletion
    kconfig
    kconfigwidgets
    kcoreaddons
    kdbusaddons
    kdeclarative
    ki18n
    kiconthemes
    kio
    kitemmodels
    plasma-framework
    plasma-workspace
    kservice
    ktexteditor
    kwidgetsaddons
    kirigami2
  ]) ++ (with pkgs.libsForQt5.qt5; [
    qtbase
    qtquickcontrols2
    qtgraphicaleffects
  ]);
}

