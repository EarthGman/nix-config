{ wallpapers, ... }:
{
  imports = [
    ./disko.nix
  ];

  profiles.gaming.enable = true;

  boot = {
    initrd.availableKernelModules = [
      "nvme"
      "ahci"
      "xhci_pci"
      "usb_storage"
      "usbhid"
      "sd_mod"
    ];
  };

  services.displayManager.gdm.enable = false;
  services.displayManager.sddm.enable = true;
}
