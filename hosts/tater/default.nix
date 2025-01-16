{ self, config, pkgs, ... }:
{
  imports = [
    ./disko.nix
    (self + /profiles/nixos/workstation.nix)
    (self + /profiles/nixos/keyd/gmans-keymap.nix)
  ];
  boot.initrd.availableKernelModules = [
    "ahci"
    "xhci_pci"
    "sr_mod"
    "usb_storage"
  ];
  boot.kernelModules = [ "wl" ];

  boot.extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ]; # needed for this specific PC's wireless card

  modules = {
    onepassword.enable = true;
  };

  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
  };

  # custom = {
  #   decreased-security.nixos-rebuild = true;
  # };
}
