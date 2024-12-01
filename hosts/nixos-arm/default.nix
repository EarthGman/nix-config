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
  hardware.graphics.enable32Bit = false;
}
