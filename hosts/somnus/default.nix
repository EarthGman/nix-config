{ outputs
, ...
}:
{
  imports = [
    ./fs.nix
  ];
  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "ahci"
    "usbhid"
    "usb_storage"
    "sd_mod"
  ];
  boot.loader.grub.extraEntries = ''
    menuentry 'Windows 10' --class windows --class os {
      insmod part_gpt
      insmod ntfs
      search --no-floppy --fs-uuid --set=root 1836-033E
      chainloader /efi/Microsoft/Boot/bootmgfw.efi
    }
  '';
  services.displayManager.sddm.themeConfig = {
    Background = outputs.wallpapers.the-gang-2;
    ScreenWidth = "2560";
    ScreenHeight = "1440";
    FullBlur = "false";
    PartialBlur = "false";
    MainColor = "##e3688c";
    AccentColor = "#f099ff";
    BackgroundColor = "#744fdd";
    placeholderColor = "#e3688c";
    IconColor = "#e3688c";
  };
}
