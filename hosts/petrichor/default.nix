{ pkgs, wallpapers, ... }:
{
  imports = [
    ./disko.nix
  ];

  profiles.gaming.enable = true;

  boot.initrd.availableKernelModules = [
    "nvme"
    "ahci"
    "xhci_pci"
    "usb_storage"
    "usbhid"
    "sd_mod"
  ];
  # display manager customization
  services.displayManager = {
    gdm.enable = false;
    sddm = {
      enable = true;
      themeConfig = {
        Background = builtins.fetchurl wallpapers.celeste-mountain;
      };
    };
  };

  programs.blender.enable = true;
}
