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

    loader.grub.themeConfig = {
      background = builtins.fetchurl wallpapers.hollow-knight-minimal;
    };
  };

  services = {
    displayManager = {
      gdm.enable = false;
      sddm = {
        themeConfig = {
          Background = builtins.fetchurl wallpapers.hallownest;
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
    };
  };
}
