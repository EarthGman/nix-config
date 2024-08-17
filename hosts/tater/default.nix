{ inputs, pkgs, ... }:
{
  imports = [
    inputs.disko.nixosModules.disko
    ./disko.nix
  ];
  boot.kernelPackages = pkgs.linuxPackages_6_9;
  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ahci"
    "usb_storage"
    "sd_mod"
    "rtsx_pci_sdmmc"
  ];
  boot.kernelModules = [
    "wl"
  ];

  # wireless driver for this machine is not included in linux kernel
  boot.extraModulePackages = with pkgs.linuxKernel.packages.linux_6_9; [
    broadcom_sta
  ];
  custom.onepassword.enable = true;
  services.nordvpn.enable = true;
}
