{ lib, config, ... }:
{
  imports = [
    ./disko
  ];

  gman.steam.enable = true;

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

  time.timeZone = "America/Chicago";

  gman = {
    printing.enable = false;
  };

  programs = {
    zotero.enable = true;
    ffxiv-launcher.enable = true;
    lutris.enable = true;
    bottles.enable = true;
    r2modman.enable = true;
    discord.enable = true;
    prismlauncher.enable = true;
    gthumb.enable = true;
    neovim-custom.enable = false;
    piper.enable = false;
    gnome-text-editor.enable = true;
  };

  services.displayManager.gdm.enable = false;
  services.displayManager.sddm.enable = true;

  # nvidia 575
  hardware.nvidia = {
    gsp.enable = false;
    open = false;
    package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
      version = "575.64.05";
      sha256_64bit = "sha256-hfK1D5EiYcGRegss9+H5dDr/0Aj9wPIJ9NVWP3dNUC0=";
      settingsSha256 = lib.fakeSha256;
      persistencedSha256 = lib.fakeSha256;
    };
  };
  nixpkgs.config.nvidia.acceptLicense = true;
}
