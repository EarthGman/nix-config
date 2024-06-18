{ inputs, pkgs, ... }:
{
  imports = [
    inputs.disko.nixosModules.disko
    ./disko.nix
    ./users
    ./boot.nix
    ./hardware.nix
    ./networking.nix
  ];
  environment.systemPackages = with pkgs; [
    broadcom-bt-firmware
    linuxKernel.packages.linux_zen.broadcom_sta
  ];
}
