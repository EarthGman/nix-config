{ lib, ... }:
{
  services.keyd.enable = lib.mkDefault true;
}
