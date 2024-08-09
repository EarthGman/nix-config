{ outputs, pkgs, ... }:
{
  imports = [
    ./disko.nix
  ];

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
  boot.loader.grub.themeConfig = {
    background = outputs.wallpapers.blackspace;
  };

  services.displayManager.sddm.themeConfig = {
    Background = outputs.wallpapers.the-gang-headspace-2;
    ScreenWidth = "2560";
    ScreenHeight = "1440";
    FullBlur = "false";
    PartialBlur = "false";
    MainColor = "#FFFFFF";
    AccentColor = "#f099ff";
    BackgroundColor = "#ffffff";
    placeholderColor = "#ffffff";
    IconColor = "#ffffff";
    FormPosition = "left";
    Font = "DejaVuSans 12";
    HourFormat = "hh:mm A";
  };
  custom.enableSteam = true;
}
