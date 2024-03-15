{ pkgs, config, ... }:
{
  boot = {
    kernelParams = [
      "quiet"
      "noatime"
    ];
    loader = {
      kernelPackages = pkgs.linuxPackages_latest;
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
