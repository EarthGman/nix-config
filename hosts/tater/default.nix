{ pkgs, ... }:
{
  imports = [
    ./disko.nix
  ];
  boot.initrd.availableKernelModules = [
    "ahci"
    "xhci_pci"
    "sr_mod"
    "usb_storage"
  ];
  boot.kernelModules = [ "wl" ];

  boot.kernelPackages = pkgs.linuxPackages_6_10;
  boot.extraModulePackages = with pkgs; [
    linuxKernel.packages.linux_6_10.broadcom_sta
  ];

  custom = {
    onepassword.enable = true;
  };
}
