{ pkgs, outputs, ... }:
{
  imports = [
    ./disko.nix
  ];
  # IMPORTANT nvidia driver fails to build with latest kernel (8/6/2024)
  boot = {
    initrd.availableKernelModules = [
      "nvme"
      "ahci"
      "xhci_pci"
      "usb_storage"
      "usbhid"
      "sd_mod"
    ];
    kernelPackages = pkgs.nixpkgs_2024-08-14.linuxPackages_6_9;
  };
  custom.steam.enable = true;
  services = {
    nordvpn.enable = true;
    displayManager.sddm.themeConfig = {
      Background = outputs.wallpapers.slime-puddle;
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
