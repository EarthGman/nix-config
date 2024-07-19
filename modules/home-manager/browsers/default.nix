{ lib, ... }:
{
  imports = [
    ./firefox
  ];
  firefox.enable = lib.mkDefault true;
}
