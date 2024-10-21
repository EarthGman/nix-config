{ self, wallpapers, ... }:
{
  imports = [
    ./disko.nix
    (self + /profiles/nixos/workstation.nix)
  ];
  boot.initrd.availableKernelModules = [
    "ahci"
    "xhci_pci"
    "usb_storage"
    "usbhid"
    "sd_mod"
  ];
  services.displayManager.sddm.themeConfig = {
    Background = builtins.fetchurl wallpapers.mt-ebott;
    ScreenWidth = "1366";
    ScreenHeight = "768";
    FullBlur = "false";
    PartialBlur = "false";
    MainColor = "#352500";
    AccentColor = "#df8b25";
    BackgroundColor = "#ffffff";
    placeholderColor = "#ffffff";
    IconColor = "#df8b25";
    FormPosition = "center";
    Font = "DejaVuSans 12";
    FontSize = "10";
    HourFormat = "hh:mm A";
  };
}
