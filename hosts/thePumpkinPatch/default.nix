{ wallpapers, ... }:
{
  imports = [
    ./disko.nix
  ];

  profiles.gaming.enable = true;

  boot = {
    initrd.availableKernelModules = [
      "nvme"
      "ahci"
      "xhci_pci"
      "usb_storage"
      "usbhid"
      "sd_mod"
    ];
  };

  programs = {
    ffxiv-launcher.enable = true;
    lutris.enable = true;
    bottles.enable = true;
    r2modman.enable = true;
    discord.enable = true;
    prismlauncher.enable = true;
    gthumb.enable = true;
    neovim-custom.enable = false;
  };

  services.displayManager.gdm.enable = false;
  services.displayManager.sddm.enable = true;
}
