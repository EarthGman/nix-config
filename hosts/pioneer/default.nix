{ outputs, pkgs, ... }:
{
  imports = [
    ./disko.nix
  ];
  boot.initrd.availableKernelModules = [
    "ahci"
    "xhci_pci"
    "usb_storage"
    "usbhid"
    "sd_mod"
  ];
  services.displayManager.sddm.themeConfig = {
    Background = outputs.wallpapers.two-hallow-knights;
    ScreenWidth = "1366";
    ScreenHeight = "768";
    FullBlur = "false";
    PartialBlur = "false";
    MainColor = "#bfe2e8";
    AccentColor = "#bfe2e8";
    BackgroundColor = "#ffffff";
    placeholderColor = "#ffffff";
    IconColor = "#ffffff";
    FormPosition = "center";
    Font = "DejaVuSans 12";
    FontSize = "10";
    HourFormat = "hh:mm A";
  };
}
