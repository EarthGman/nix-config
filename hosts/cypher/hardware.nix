{ config, lib, pkgs, modulesPath, ... }:
{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "ahci" "xhci_pci" "usb_storage" "usbhid" "sd_mod" ];
  boot.kernelModules = [ "kvm-amd" ];

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/7c42f766-936f-4151-9adb-a5ad7bc78c1c";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/62EC-36BF";
      fsType = "vfat";
    };

  fileSystems."/home" =
    {
      device = "/dev/disk/by-uuid/3da36302-fc10-4a28-899e-f80184cce304";
      fsType = "ext4";
    };

  fileSystems."/home/g/games" =
    {
      device = "/dev/disk/by-uuid/5c47fb72-3b2f-4135-b704-913a8b417907";
      fsType = "ext4";
    };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/392290eb-e3ac-47fc-b7c7-a2759c5f2ead"; }];

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
