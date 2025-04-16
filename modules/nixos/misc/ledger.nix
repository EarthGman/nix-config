{ pkgs, lib, config, ... }:
{
  options.modules.ledger.enable = lib.mkEnableOption "enable ledger module, udev rules and ledger live desktop";
  config = lib.mkIf config.modules.ledger.enable {
    hardware.ledger.enable = true;
    environment.systemPackages = [ pkgs.ledger-live-desktop ];
  };
}
