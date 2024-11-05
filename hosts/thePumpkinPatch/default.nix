{ self, wallpapers, ... }:
{
  imports = [
    ./disko.nix
    (self + /profiles/nixos/gaming-pc.nix)
  ];
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
  services = {
    nordvpn.enable = true;
    displayManager.sddm.themeConfig = {
      Background = builtins.fetchurl wallpapers.slime-puddle;
      ScreenWidth = "2560";
      ScreenHeight = "1440";
      FullBlur = "false";
      PartialBlur = "false";
      FormPosition = "right";
      MainColor = "#cd4967";
      AccentColor = "#000000";
      BackgroundColor = "#000000";
      placeholderColor = "#302a19";
      IconColor = "#cd4967";
      HourFormat = "hh:mm A";
      FontSize = "16";
    };
  };
}
