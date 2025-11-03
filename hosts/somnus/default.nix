{
  pkgs,
  ...
}:
{
  imports = [
    ./disko.nix
  ];

  gman.steam.enable = true;

  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "ahci"
    "usbhid"
    "usb_storage"
    "sd_mod"
  ];

  time.timeZone = "America/Chicago";

  environment.systemPackages = with pkgs; [
    liquidctl
  ];

  services = {
    hardware.openrgb = {
      enable = true;
    };
  };

  programs = {
    dolphin-emu.enable = true;
    cemu.enable = true;
    prismlauncher.enable = true;
    discord.enable = true;
    xivlauncher.enable = true;
    lutris.enable = true;
    bottles.enable = true;

    cmatrix.enable = true;
    cbonsai.enable = true;
    pipes.enable = true;
    ryubing.enable = true;
    sl.enable = true;
  };

  #allow liquidctl without sudo (kraken z73)
  services.udev.extraRules = ''
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="1e71", ATTRS{idProduct}=="3008", TAG+="uaccess"
  '';

  # boot.loader.grub.extraEntries = ''
  #   menuentry 'Windows 10' --class windows --class os {
  #     insmod part_gpt
  #     insmod ntfs
  #     search --no-floppy --fs-uuid --set=root 1836-033E
  #     chainloader /efi/Microsoft/Boot/bootmgfw.efi
  #   }
  # '';
}
