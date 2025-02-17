{ pkgs, ... }:
{
  imports = [ ./disko.nix ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ehci_pci"
    "ahci"
    "usb_storage"
    "sd_mod"
    "rtsx_pci_sdmmc"
  ];

  boot.kernelParams = [ "video=1366x768" ];

  boot.extraModprobeConfig = ''
    blacklist mei_me
  '';

  boot.loader = {
    # remove efi from grub since we are booting from SeaBIOS
    efi.canTouchEfiVariables = false;
    grub.efiSupport = false;
  };

  services.displayManager.sddm.themeConfig = {
    FullBlur = "false";
    PartialBlur = "false";
  };

  modules = {
    onepassword.enable = true;
    sops.enable = true;
  };

  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
  };
}
