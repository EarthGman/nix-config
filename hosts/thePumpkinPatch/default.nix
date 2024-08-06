{ config, pkgs, outputs, ... }:
{
  imports = [
    ./disko.nix
  ];
  # IMPORTANT nvidia driver fails to build with latest kernel (8/6/2024)
  boot = {
    initrd.availableKernelModules = [
      "nvme"
      "ahci"
      "xhci_pci"
      "usb_storage"
      "usbhid"
      "sd_mod"
    ];
    kernelPackages = pkgs.linuxPackages_6_9;
  };
  custom.enableSteam = true;
  services = {
    nordvpn.enable = true;
    displayManager.sddm.themeConfig = {
      wallpaper = outputs.wallpapers.slime-puddle;
    };
  };
}
