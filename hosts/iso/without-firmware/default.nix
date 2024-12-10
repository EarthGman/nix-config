{ lib, ... }:
let
  inherit (lib) mkForce;
in
{
  hardware.enableRedistributableFirmware = mkForce false;
  hardware.enableAllFirmware = mkForce false;
}
