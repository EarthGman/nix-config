{ pkgs, ... }:
{
  imports = [
    ./disko.nix
  ];

  profiles.gaming.enable = true;

  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "ahci"
    "usb_storage"
    "usbhid"
    "sd_mod"
  ];
  services.hardware.openrgb.enable = true;
  environment.systemPackages = with pkgs; [ liquidctl ];
}
