{ self, pkgs, config, wallpapers, ... }:
{
  imports = [
    ./fs.nix
    (self + /profiles/nixos/workstation.nix)
  ];
  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "vmd"
    "nvme"
    "usb_storage"
    "sd_mod"
    "rtsx_pci_sdmmc"
  ];

  boot.kernelParams = [
    "intel_iommu=on"
  ];

  boot.kernelModules = [
    "vfio_pci"
    "vfio"
    "vfio_iommu_type1"
  ];

  services.displayManager.sddm.themeConfig = {
    Background = builtins.fetchurl wallpapers.fiery-dragon;
    FullBlur = "false";
    PartialBlur = "false";
  };

  modules = {
    steam.enable = true;
    onepassword.enable = true;
    qemu-kvm.enable = true;
    sops.enable = true;
  };

  # custom = {
  #   decreased-security.nixos-rebuild = true;
  # };

  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
  };

  sops.secrets.wg0_conf.path = "/etc/wireguard/wg0.conf";

  networking.localCommands = ''
    ip route add 10.10.0.0/24 via 10.0.0.1 dev wg0
  '';
  networking.firewall.allowedUDPPorts = [ 51820 ];
  networking.nameservers = [ "10.0.0.1" ]; # wg nameserver
  networking.wg-quick.interfaces = {
    wg0 = {
      configFile = config.sops.secrets.wg0_conf.path;
    };
  };
}
