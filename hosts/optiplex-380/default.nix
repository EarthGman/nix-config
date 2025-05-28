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

  nix.settings.trusted-users = [ "g" ];
  zramSwap.enable = true;

  modules = {
    onepassword.enable = true;
    sops.enable = true;
    bluetooth.enable = false;
  };

  profiles = {
    gmans-keymap.enable = true;
  };

  programs = {
    easyeffects.enable = false;
    helvum.enable = false;
    glabels.enable = true;
    zint.enable = true;
  };
}
