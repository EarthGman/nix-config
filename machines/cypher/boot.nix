{ pkgs, lib, config, ... }:

{
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.tmp.cleanOnBoot = true;

  boot.kernelParams = [
    "video=1920x1080"
    "quiet"
    "noatime"
    "amd_iommu=on"
  ];

  boot.kernelModules = [
    "kvm-amd"
    "vfio_pci"
    "vfio"
    "vfio_iommu_type1"
    "vfio_virqfd"
  ];

  boot.extraModprobeConfig = ''
    options vfio-pci ids=1002:164e,1002:1640
    softdep amdgpu pre: vfio-pci
  '';

  # grub
  boot.loader = {
    efi.canTouchEfiVariables = true;
    efi.efiSysMountPoint = "/boot";
    grub.enable = true;
    grub.efiSupport = true;
    # grub.useOSProber = true;
    grub.gfxmodeEfi = "640x480";
    grub.devices = [ "nodev" ];
    grub.extraEntries = ''
      menuentry "Reboot" {
        reboot
      }
      menuentry "Poweroff" {
        halt
      }
    '';
    timeout = 10;
  };

  # virtual camera for obs
  boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
}
