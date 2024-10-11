{ wallpapers, ... }:
{
  imports = [
    ./disko.nix
  ];
  boot.initrd.availableKernelModules = [
    "nvme"
    "ahci"
    "xhci_pci"
    "usb_storage"
    "usbhid"
    "sd_mod"
  ];
  modules.steam.enable = true;
  # display manager customization
  services.displayManager.sddm.themeConfig = {
    Background = builtins.fetchurl wallpapers.survivors;
  };
}
