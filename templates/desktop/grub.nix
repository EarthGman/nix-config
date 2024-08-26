{ pkgs, lib, config, ... }:
let
  inherit (lib) mkOption types mkDefault;
  cfg = config.boot.loader.grub;
in
{
  options.boot.loader.grub = {
    themeConfig = mkOption {
      description = "extra config options for grub themes";
      default = { };
      type = types.attrsOf types.str;
    };
    themeName = mkOption {
      description = "name of the grub theme from pkgs/themes/grub. Name must match exactly minus .nix";
      type = types.str;
      default = "nixos";
    };
  };
  config =
    let
      theme = pkgs.grub-themes."${cfg.themeName}".override {
        inherit (cfg) themeConfig;
      };
    in
    {
      boot = {
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
            inherit theme;
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
              menuentry 'UEFI Firmware Settings' --id 'uefi-firmware' {
                fwsetup
              }
            '';
          };
          timeout = mkDefault 10;
        };
      };
    };
}
