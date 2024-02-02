{ pkgs, config, ... }:
{
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [
      "quiet"
      "noatime"
    ];
    kernelModules = [
      "kvm-intel"
    ];
    loader = {
      systemd-boot.enable = true;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };
  };

  # virtual camera for obs
  boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
}
