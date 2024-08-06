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
  custom.enableSteam = true;
}
