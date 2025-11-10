# modules shared between nixos and home-manager
{ lib, ... }:
{
  imports = lib.autoImport ./.;
}
