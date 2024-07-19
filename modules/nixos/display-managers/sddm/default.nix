{ pkgs, lib, config, displayManagerTheme, desktop, ... }:
let
  hasTheme = (displayManagerTheme != null);
  desktops = builtins.filter builtins.isString (builtins.split "," desktop);
  plasmaEnabled = builtins.elem "plasma" desktops;
in
{
  services.displayManager.sddm = {
    enable = true;
    wayland = {
      enable = true;
    };
    theme = lib.mkIf (hasTheme && !plasmaEnabled) "${pkgs.sddm-themes.${displayManagerTheme}}";
  };

  # note: due to the current move from plasma5 to plasma6 many sddm themes will not work with plasma6 enabled due to differing qt versions
  # However themeing sddm is fine so long as plasma is not your main desktop 
  # If plasma is not your main desktop some dependencies will be needed for the themes to work
  # environment.systemPackages = (with pkgs; [
  #   kconfig-frontends
  # ]) ++ (with pkgs.libsForQt5; [
  #   karchive
  #   kcompletion
  #   kconfig
  #   kconfigwidgets
  #   kcoreaddons
  #   kdbusaddons
  #   kdeclarative
  #   ki18n
  #   kiconthemes
  #   kio
  #   kitemmodels
  #   plasma-framework
  #   plasma-workspace
  #   kservice
  #   ktexteditor
  #   kwidgetsaddons
  #   kirigami2
  # ]) ++ (with pkgs.libsForQt5.qt5; [
  #   qtbase
  #   qtquickcontrols2
  #   qtgraphicaleffects
  # ]);
}

