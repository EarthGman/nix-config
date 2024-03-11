{ pkgs, ... }:
{
  services.xserver = {
    displayManager.sddm = {
      enable = true;
    };
  };
  # required for loading sddm themes
  environment.systemPackages = with pkgs.libsForQt5.qt5; [
    qtquickcontrols2
    qtgraphicaleffects
  ];
}
