{ wallpapers, ... }:
{
  imports = [
    ./disko.nix
  ];
  boot.initrd.availableKernelModules = [
    "ahci"
    "xhci_pci"
    "virtio_pci"
    "sr_mod"
    "virtio_blk"
  ];
  boot.loader.grub.themeConfig = {
    background = builtins.fetchurl wallpapers.blackspace;
  };
}
