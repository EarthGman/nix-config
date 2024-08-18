{ pkgs, ... }:
{
  imports = [
    ./disko.nix
  ];
  boot.initrd.availableKernelModules = [
    "ahci"
    "xhci_pci"
    "usb_storage"
    "usbhid"
    "sd_mod"
  ];
}
