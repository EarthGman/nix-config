{ outputs, pkgs, lib, wallpapers, ... }:
{
  imports = [
    ./fs.nix
    ./sddm.nix
    outputs.nixosProfiles.gaming
    outputs.nixosProfiles.gman-pc
  ];


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

  # boot.binfmt.emulatedSystems = [
  #   "aarch64-linux"
  # ];

  hardware.amdgpu.opencl.enable = true;

  networking = {
    # required for sins of a solar empire lag bug in multiplayer
    extraHosts = ''66.79.209.80 ico-reb.stardock.com'';

    firewall.allowedUDPPorts = [ 8001 ];
  };

  boot.loader.grub.themeConfig = {
    background = builtins.fetchurl wallpapers.april-red;
  };

  modules = {
    benchmarking.enable = true;
    flatpak.enable = true;
    sunshine.enable = true;
    qemu-kvm.enable = true;
  };

  #  custom = {
  #    decreased-security.nixos-rebuild = true;
  #  };

  virtualisation.libvirtd.hooks.qemu = {
    "looking-glass-hook" = lib.getExe (pkgs.writeShellApplication {
      name = "looking-glass-hook";
      runtimeInputs = [ pkgs.bash ];
      text = ''
        if [ "$1" = "windows" ] && [ "$2" = "started" ]; then
          sleep 1
          chown g:users /dev/shm/looking-glass
          chmod 660 /dev/shm/looking-glass
        fi
      '';
    });
  };

  environment.systemPackages = with pkgs; [
    gnome-software
  ];

  environment.etc = {
    "ssh/ssh_host_ed25519_key.pub".source = ./ssh_host_ed25519_key.pub;
    "ssh/ssh_host_rsa_key.pub".source = ./ssh_host_rsa_key.pub;
  };

  sops.secrets = {
    ssh_host_ed25519_key.path = "/etc/ssh/ssh_host_ed25519_key";
    ssh_host_rsa_key.path = "/etc/ssh/ssh_host_rsa_key";
  };
}
