{
  pkgs,
  lib,
  config,
  ...
}@args:
let
  bios = if args ? bios then args.bios else null;
  inherit (lib)
    mkOption
    types
    mkDefault
    mkEnableOption
    mkIf
    optionalString
    ;
  cfg = config.boot.loader.grub;
in
{
  options = {
    modules.bootloaders.grub.enable = mkEnableOption "enable grub boot loader";
    boot.loader.grub = {
      themeConfig = mkOption {
        description = "extra config options for grub themes";
        default = { };
        type = types.attrsOf types.str;
      };
      themeName = mkOption {
        description = "name of the grub theme from pkgs/themes/grub. Name must match exactly minus .nix";
        type = types.str;
        default = "nixos-grub";
      };
    };
  };
  config =
    let
      theme = pkgs."${cfg.themeName}".override {
        inherit (cfg) themeConfig;
      };
    in
    mkIf config.modules.bootloaders.grub.enable {
      boot = {
        kernelParams = [
          "quiet"
          "noatime"
        ];
        loader = {
          efi.canTouchEfiVariables = mkDefault (bios == "UEFI");
          grub = {
            enable = true;
            inherit theme;
            efiSupport = (bios == "UEFI");
            devices = [ "nodev" ];
            gfxmodeEfi = "1920x1080";
            extraEntries =
              ''
                menuentry "Reboot" {
                  reboot
                }
                menuentry "Poweroff" {
                  halt
                } 
              ''
              + optionalString (bios == "UEFI") ''
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
