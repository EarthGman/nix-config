{ self, outputs, config, pkgs, ... }:
{
  imports = [
    ./disko.nix
    outputs.nixosProfiles.laptop
    outputs.nixosProfiles.gmans-keymap
    (self + /profiles/nixos/wg0.nix)
  ];
  boot.initrd.availableKernelModules = [
    "ahci"
    "xhci_pci"
    "sr_mod"
    "usb_storage"
  ];
  boot.kernelModules = [ "wl" ];

  boot.extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ]; # needed for this specific wireless card

  modules = {
    onepassword.enable = true;
    sops.enable = true;
  };

  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
  };

  zramSwap = {
    enable = true;
  };

  # custom = {
  #   decreased-security.nixos-rebuild = true;
  # };
}
