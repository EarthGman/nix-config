{ config, pkgs, ... }:
{
  imports = [
    ./disko.nix
  ];
  # IMPORTANT nvidia driver fails to build with latest kernel (8/6/2024)
  boot = {
    kernelPackages = pkgs.linuxPackages_6_9;
  };
  custom.enableSteam = true;

}
