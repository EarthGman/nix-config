{
  self,
  outputs,
  wallpapers,
  ...
}:
{
  imports = [
    ./disko.nix
  ];

  profiles.laptop.enable = true;

  boot.initrd.availableKernelModules = [
    "ahci"
    "xhci_pci"
    "usb_storage"
    "usbhid"
    "sd_mod"
  ];

  zramSwap.enable = true;
}
