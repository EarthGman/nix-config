{
  imports = [ ./disko.nix ];
  boot.initrd.availableKernelModules = [
    "uhci_hcd"
    "ehci_pci"
    "ata_piix"
    "usbhid"
    "usb_storage"
    "sd_mod"
  ];

  modules = {
    onepassword.enable = true;
    sops.enable = true;
  };
}
