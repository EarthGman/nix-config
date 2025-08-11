{
  ...
}:
{
  imports = [
    ./disko.nix
  ];

  time.timeZone = "America/Chicago";

  boot.initrd.availableKernelModules = [
    "ahci"
    "xhci_pci"
    "usb_storage"
    "usbhid"
    "sd_mod"
  ];

  # only 4GB of ram
  zramSwap.enable = true;
}
