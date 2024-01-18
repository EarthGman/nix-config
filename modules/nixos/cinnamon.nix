# enables the cinnamon desktop

{ pkgs, ... }:
{
  services.xserver = {
    enable = true;
    libinput.enable = true;
    displayManager.sddm.enable = true;
    desktopManager.cinnamon.enable = true;
    displayManager.defaultSession = "cinnamon";
  };
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
  programs.dconf.enable = true;

  environment.systemPackages = with pkgs; [
    gnome.gnome-system-monitor # gnome's task manager (not prebuilt into cinnamon)
  ];
}
