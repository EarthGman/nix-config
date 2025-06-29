{ pkgs, wallpapers, ... }:
{
  imports = [
    ./sddm.nix
    ./disko.nix
  ];

  profiles = {
    gman-pc.enable = true;
    gaming.enable = true;
  };

  # jovian.decky-loader.enable = true;

  boot.initrd.availableKernelModules = [
    "nvme"
    "ahci"
    "xhci_pci"
    "thunderbolt"
    "usb_storage"
    "usbhid"
    "sd_mod"
  ];
  boot.kernelParams = [
    "amd_iommu=on"
    "iommu=pt"
  ];

  boot.kernelModules = [
    "vfio_pci"
    "vfio"
    "vfio_iommu_type1"
  ];

  boot.extraModprobeConfig = ''
    options vfio-pci ids=1002:164e,1002:1640,10de:1c02,10de:10f1
    softdep amdgpu pre: vfio-pci
    softdep nvidia pre: vfio-pci
  '';

  fileSystems."/home/g/games" = {
    device = "/dev/disk/by-label/games";
    fsType = "ext4";
  };

  # boot.binfmt.emulatedSystems = [
  #   "aarch64-linux"
  # ];

  hardware.amdgpu.opencl.enable = true;

  networking = {
    # required for sins of a solar empire lag bug in multiplayer
    extraHosts = ''66.79.209.80 ico-reb.stardock.com'';
  };

  boot.loader.grub.themeConfig = {
    background = builtins.fetchurl wallpapers.april-red;
  };

  modules = {
    benchmarking.enable = true;
    flatpak.enable = true;
    qemu-kvm.enable = true;
  };

  programs = {
    cutentr.enable = true;
    piper.enable = false;
    blender.enable = true;
    ani-cli.enable = true;
  };

  services.sunshine.enable = true;

  environment = {
    systemPackages = with pkgs; [
      nixos-generators
      rojo
    ];

    etc = {
      "ssh/ssh_host_ed25519_key.pub".source = ./ssh_host_ed25519_key.pub;
      "ssh/ssh_host_rsa_key.pub".source = ./ssh_host_rsa_key.pub;
    };
  };

  sops.secrets = {
    ssh_host_ed25519_key.path = "/etc/ssh/ssh_host_ed25519_key";
    ssh_host_rsa_key.path = "/etc/ssh/ssh_host_rsa_key";
  };
}
