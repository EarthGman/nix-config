{ pkgs, config, ... }:
{
  #latest linux kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.kernelParams = [
    "video=1920x1080"
    "intel_iommu=on"
    "iommu=pt"
    "quiet"
    "noatime"
  ];
  boot.kernelModules = [
    "vfio_virqfd"
    "vfio_pci"
    "vfio_iommu_type1"
    "vfio"
    "kvm-intel"
  ];
  boot.blacklistedKernelModules = [ "coffeelake" "nouveau" ];
  boot.extraModprobeConfig = "options vfio-pci ids=8086:3e92,8086:a348";

  #boot - grub 2
  #boot.loader.systemd-boot.enable = true;
  boot.loader = {
    efi.canTouchEfiVariables = true;
    efi.efiSysMountPoint = "/boot";
    grub.enable = true;
    grub.efiSupport = true;
    #grub.useOSProber = true;
    grub.devices = [ "nodev" ];
    grub.extraEntries = ''
      menuentry 'Windows 10' --class windows --class os {
        insmod part_gpt
        insmod ntfs
        search --no-floppy --fs-uuid --set=root 42AD-8EF4
        chainloader /efi/Microsoft/Boot/bootmgfw.efi
      }
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
