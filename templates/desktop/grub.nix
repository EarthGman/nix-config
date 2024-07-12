{ pkgs, lib, config, ... }:
{
  boot = {
    kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;
    extraModulePackages = [
      # for obs virtual camera
      config.boot.kernelPackages.v4l2loopback
    ];
    kernelParams = [
      "video=1920x1080"
      "quiet"
      "noatime"
    ];
    tmp.cleanOnBoot = true;
    loader = {
      efi = {
        canTouchEfiVariables = true;
      };
      grub = {
        enable = true;
        # theme = TODO
        efiSupport = true;
        devices = [ "nodev" ];
        gfxmodeEfi = "1920x1080";
        extraEntries = ''
          menuentry "Reboot" {
            reboot
          }
          menuentry "Poweroff" {
            halt
          }
        '';
      };
      timeout = lib.mkDefault 10;
    };
  };
}
