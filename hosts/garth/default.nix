{ self, pkgs, config, wallpapers, ... }:
{
  imports = [
    ./fs.nix
    (self + /profiles/nixos/workstation.nix)
    (self + /profiles/nixos/wg0.nix)
    (self + /profiles/nixos/keyd/gmans-keymap.nix)
  ];
  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "vmd"
    "nvme"
    "usb_storage"
    "sd_mod"
    "rtsx_pci_sdmmc"
  ];

  boot.kernelParams = [
    "intel_iommu=on"
  ];

  boot.kernelModules = [
    "vfio_pci"
    "vfio"
    "vfio_iommu_type1"
  ];

  services.displayManager.sddm.themeConfig = {
    Background = builtins.fetchurl wallpapers.fiery-dragon;
    FullBlur = "false";
    PartialBlur = "false";
  };

  modules = {
    steam.enable = true;
    onepassword.enable = true;
    qemu-kvm.enable = true;
    sops.enable = true;
  };

  # custom = {
  #   decreased-security.nixos-rebuild = true;
  # };

  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
  };
}
