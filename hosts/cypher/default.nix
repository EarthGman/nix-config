{ self, pkgs, lib, config, wallpapers, ... }:
{
  imports = [
    ./fs.nix
    ./sddm.nix
    (self + /profiles/nixos/gaming.nix)
    (self + /profiles/nixos/wg0.nix)
  ];
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

  modules = {
    onepassword.enable = true;
    sunshine.enable = true;
    qemu-kvm.enable = true;
    sops.enable = true;
    ledger.enable = true;
  };

  #  custom = {
  #    decreased-security.nixos-rebuild = true;
  #  };

  virtualisation.libvirtd.hooks.qemu = {
    "looking-glass-hook" = lib.getExe (pkgs.writeShellApplication {
      name = "looking-glass-hook";
      runtimeInputs = [ pkgs.bash ];
      text = ''
        if [ "$2" = "started" ]; then
          sleep 1
          chown g:users /dev/shm/looking-glass
          chmod 660 /dev/shm/looking-glass
        fi
      '';
    });
  };

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
  };
}
