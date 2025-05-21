{ wallpapers, ... }:
{
  imports = [
    ./disko.nix
  ];

  profiles.gaming.enable = true;

  boot.initrd.availableKernelModules = [
    "nvme"
    "ahci"
    "xhci_pci"
    "usb_storage"
    "usbhid"
    "sd_mod"
  ];
  # display manager customization
  services.displayManager.sddm.themeConfig = {
    Background = builtins.fetchurl wallpapers.celeste-mountain;
  };
}
