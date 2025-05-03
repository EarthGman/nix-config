{ lib, config, ... }@args:
let
  bios = if args ? bios then args.bios else null;
in
{
  options.modules.bootloaders.systemd-boot.enable = lib.mkEnableOption "enable systemd-boot module";
  config = lib.mkIf config.modules.bootloaders.systemd-boot.enable {
    boot.loader = {
      efi.canTouchEfiVariables = lib.mkDefault (bios == "UEFI");
      systemd-boot.enable = true;
    };
  };
}
