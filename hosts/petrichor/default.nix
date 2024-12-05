{ self, wallpapers, ... }:
{
  imports = [
    (self + /profiles/nixos/gaming.nix)
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
  # display manager customization
  services.displayManager.sddm.themeConfig = {
    Background = builtins.fetchurl wallpapers.survivors;
  };
}
