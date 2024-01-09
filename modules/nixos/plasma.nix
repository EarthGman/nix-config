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

  environment.plasma5.excludePackages = with pkgs.libsForQt5; [
  ];
}
