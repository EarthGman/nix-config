{ pkgs, lib, ... }:
{
  imports = [
    ./hardware.nix
  ];
  boot.kernelParams = [
    "amd_iommu=on"
  ];

  boot.kernelModules = [
    "vfio_pci"
    "vfio"
    "vfio_iommu_type1"
    "vfio_virqfd"
  ];

  boot.extraModprobeConfig = ''
    options vfio-pci ids=1002:164e,1002:1640
    softdep amdgpu pre: vfio-pci
  '';

  boot.loader.grub.theme = pkgs.grub-theme;

  networking = {
    # required for sins of a solar empire lag bug in multiplayer
    extraHosts = ''66.79.209.80 ico-reb.stardock.com'';
  };
}
