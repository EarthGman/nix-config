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
    flatpak.enable = true;
    hardware.openrgb = {
      enable = true;
    };
  };

  programs.gnome-software.enable = true;

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
