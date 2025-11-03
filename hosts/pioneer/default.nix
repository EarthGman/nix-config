{
  ...
}:
{
  imports = [
    ./disko.nix
  ];

  time.timeZone = "America/Chicago";

  boot.initrd.availableKernelModules = [
    "ahci"
    "xhci_pci"
    "usb_storage"
    "usbhid"
    "sd_mod"
  ];

  # only 4GB of ram
  zramSwap.enable = true;

  programs = {
    zotero.enable = true;
    bottles.enable = true;
    libreoffice.enable = true;
    switcheroo.enable = true;
    discord.enable = true;
    sl.enable = true;
    cmatrix.enable = true;
    cbonsai.enable = true;
    zoom-us.enable = true;
  };
}
