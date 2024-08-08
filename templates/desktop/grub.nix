{ pkgs, lib, config, grub-theme, ... }:
let
  inherit (lib) mkOption types;
  cfg = config.boot.loader.grub;
in
{
  options.boot.loader.grub.themeConfig = mkOption {
    description = ''
      extra config options for grub themes
    '';
    default = { };
    type = types.attrsOf types.str;
  };
  config =
    let
      theme = pkgs.grub-themes.${grub-theme}.override {
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
          timeout = lib.mkDefault 10;
        };
      };
    };
}
