{ pkgs, ... }:
{
  services.xserver = {
    enable = true;
    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;
  };
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

  programs.dconf.enable = true;

  environment.systemPackages = with pkgs; [
    libsForQt5.breeze-gtk
    libsForQt5.kde-gtk-config
    libsForQt5.kalk # calculator
    libsForQt5.kpmcore # library for partition manager
    partition-manager # KDE partition manager
  ];

  environment.plasma5.excludePackages = with pkgs.libsForQt5; [
  ];
}
