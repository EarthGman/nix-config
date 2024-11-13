{ self, pkgs, lib, config, displayManager, wallpapers, ... }:
{
  imports = [
    ./fs.nix
    (self + /profiles/nixos/gaming-pc.nix)
  ] ++ lib.optionals (displayManager == "sddm") [ ./sddm.nix ];
  boot.initrd.availableKernelModules = [
    "nvme"
    "ahci"
    "xhci_pci"
    "usb_storage"
    "usbhid"
    "sd_mod"
  ];
  boot.kernelParams = [
    "amd_iommu=on"
  ];

  boot.kernelModules = [
    "vfio_pci"
    "vfio"
    "vfio_iommu_type1"
  ];

  boot.extraModprobeConfig = ''
    options vfio-pci ids=1002:164e,1002:1640
    softdep amdgpu pre: vfio-pci
  '';

  boot.binfmt.emulatedSystems = [
    "aarch64-linux"
  ];

  networking = {
    # required for sins of a solar empire lag bug in multiplayer
    extraHosts = ''66.79.209.80 ico-reb.stardock.com'';
  };

  services.keyd.enable = true;

  boot.loader.grub.themeConfig = {
    background = builtins.fetchurl wallpapers.april-red;
  };

  # for davinci resolve ~4GB of bloat
  hardware.graphics = {
    extraPackages = with pkgs; [
      rocm-opencl-icd
      rocm-opencl-runtime
    ];
  };

  modules = {
    steam.enable = true;
    onepassword.enable = true;
    sunshine.enable = true;
    qemu-kvm.enable = true;
    sops.enable = true;
  };

  #  custom = {
  #    decreased-security.nixos-rebuild = true;
  #  };

  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
  };

  environment.etc = {
    "ssh/ssh_host_ed25519_key.pub".source = ./ssh_host_ed25519_key.pub;
    "ssh/ssh_host_rsa_key.pub".source = ./ssh_host_rsa_key.pub;
  };

  # use ed25519 key
  sops.gnupg.sshKeyPaths = [
    "/etc/ssh/ssh_host_ed25519_key"
    "/etc/ssh/ssh_host_rsa_key"
  ];

  sops.secrets = {
    ssh_host_ed25519_key.path = "/etc/ssh/ssh_host_ed25519_key";
    ssh_host_rsa_key.path = "/etc/ssh/ssh_host_rsa_key";
    wg0_conf.path = "/etc/wireguard/wg0.conf";
  };

  # boot.kernel.sysctl."net.ipv4.conf.all.forwarding" = true;
  networking = {
    firewall.allowedUDPPorts = [ 51820 ];
    # interfaces.default.ipv4.routes = [
    #   {
    #     address = "10.10.0.0";
    #     prefixLength = 24;
    #     via = "10.0.0.1";
    #   }
    #];
    wg-quick.interfaces = {
      wg0 = {
        configFile = config.sops.secrets.wg0_conf.path;
      };
    };
  };
}
