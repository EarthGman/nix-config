{ wallpapers, pkgs, ... }:
{
  imports = [
    ./disko
  ];

  profiles.gaming.enable = true;

  modules = {
    flatpak.enable = true;
  };

  custom = {
    decreased-security.nixos-rebuild = true;
  };

  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "ahci"
    "usbhid"
    "usb_storage"
    "sd_mod"
  ];

  environment.systemPackages = with pkgs; [
    liquidctl
  ];
  services.hardware.openrgb = {
    enable = true;
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
