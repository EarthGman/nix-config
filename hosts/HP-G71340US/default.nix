{
  imports = [ ./disko.nix ];
  profiles.essentials.enable = true;

  zramSwap.enable = true;

  boot.initrd.availableKernelModules = [
    "uhci_hcd"
    "ehci_pci"
    "ahci"
    "usb_storage"
    "sd_mod"
    "sr_mod"
  ];

  boot.loader.grub.gfxmodeBios = "1600x900";

  services.openssh.settings.PasswordAuthentication = true;
  programs = {
    openboardview.enable = true;
  };
}
