# This module is not meant to be consumed outside of lib.mkHost
# provides hardware-configuration for machines based on specific parameters
{ lib, config, hostName, cpu, vm, system, stateVersion, desktop, iso, server, ... }:
let
  inherit (lib) mkDefault mkIf;
in
{
  profiles = {
    iso.enable = iso;
    server.enable = server;
    qemu-guest.enable = vm;
    desktop.enable = desktop != null;
  };

  networking = {
    inherit hostName;
  };

  nixpkgs.hostPlatform = system;
  system = {
    inherit stateVersion;
  };

  hardware.cpu.${cpu}.updateMicrocode = mkIf (!vm)
    (mkDefault config.hardware.enableRedistributableFirmware);
}
