{ lib, ... }:
{
  imports = [
    ./firefox
    ./brave
  ];
  firefox.enable = lib.mkDefault true;
}
