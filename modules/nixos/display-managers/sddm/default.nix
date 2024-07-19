{ pkgs, lib, config, displayManagerTheme, desktop, ... }:
let
  hasTheme = (displayManagerTheme != null);
  desktops = builtins.filter builtins.isString (builtins.split "," desktop);
  plasmaEnabled = builtins.elem "plasma" desktops;
  optional = lib.optionals (!plasmaEnabled);
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
  # However themeing sddm is fine so long as plasma is not enabled 
  # If plasma is not your main desktop some dependencies will be needed for the themes to work
  environment.systemPackages = optional
    (with pkgs.libsForQt5; [
      plasma-framework
      plasma-workspace
      kdeclarative
      kirigami2
    ]) ++ optional (with pkgs.libsForQt5.qt5; [
    qtgraphicaleffects
  ]);
}

