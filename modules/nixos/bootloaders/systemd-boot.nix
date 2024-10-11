{ lib, config, ... }:
{
  options.modules.bootloaders.systemd-boot.enable = lib.mkEnableOption "enable systemd-boot module";
  config = lib.mkIf config.modules.bootloaders.systemd-boot.enable {
    boot.loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
  };
}
