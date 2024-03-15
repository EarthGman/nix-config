{ pkgs, config, ... }:
{
  boot = {
    kernelParams = [
      "quiet"
      "noatime"
    ];
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      grub = {
        enable = true;
        device = "/dev/vda";
      };
    };
  };
}
