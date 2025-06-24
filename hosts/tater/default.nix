{ config, ... }:
{
  imports = [
    ./disko.nix
  ];

  profiles = {
    laptop.enable = true;
    gman-pc.enable = true;
    hacker-mode.enable = false;
    wg0.enable = true;
  };

  modules = {
    onepassword.enable = true;
  };

  boot.initrd.availableKernelModules = [
    "ahci"
    "xhci_pci"
    "sr_mod"
    "usb_storage"
  ];

  boot.extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ]; # needed for this specific wireless card

  zramSwap = {
    enable = true;
  };
}
