{ lib, ... }:
{
  services.keyd.enable = lib.mkDefault true;
  services.power-profiles-daemon.enable = lib.mkDefault true;
}
