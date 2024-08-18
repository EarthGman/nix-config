{ outputs, ... }:
{
  imports = [
    ./fs.nix
  ];
  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "vmd"
    "nvme"
    "usb_storage"
    "sd_mod"
    "rtsx_pci_sdmmc"
  ];
  services.displayManager.sddm.themeConfig = {
    Background = outputs.wallpapers.fiery-dragon;
    FullBlur = "false";
    PartialBlur = "false";
  };
  custom = {
    steam.enable = true;
    steam.remotePlay = true;
    onepassword.enable = true;
  };
  services.displayManager.defaultSession = "none+i3";
  services.nordvpn.enable = true;
  services.zerotierone = {
    enable = true;
    joinNetworks = [
      # personal darkweb
      "d5e5fb653723b80e"
    ];
  };
}
