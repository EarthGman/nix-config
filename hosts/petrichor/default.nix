{ outputs, ... }:
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
  custom.steam.enable = true;
  # display manager customization
  services.displayManager.sddm.themeConfig = {
    Background = outputs.wallpapers.survivors;
  };
}
