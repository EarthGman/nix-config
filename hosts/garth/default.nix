{ pkgs, wallpapers, ... }:
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

  custom = {
    decreased-security.nixos-rebuild = true;
  };

  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
  };

  services.nordvpn.enable = true;
  services.zerotierone = {
    enable = true;
    joinNetworks = [
      # personal darkweb
      "d5e5fb653723b80e"
    ];
  };
}
