{ pkgs, config, ... }:
{
  #latest linux kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.kernelParams = [
    "video=3840x2160"
    "quiet"
    "noatime"
  ];
  boot.kernelModules = [
    "kvm-amd"
  ];
  boot.initrd.kernelModules = [
    "amdgpu"
  ];

  # boot.loader.systemd-boot.enable = true;

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
