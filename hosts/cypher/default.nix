{
  inputs,
  pkgs,
  lib,
  system,
  ...
}:
let
  inherit (lib) mkForce;
in
{
  imports = [
    ./sddm.nix
    ./disko.nix
  ];

  profiles = {
    benchmarking.enable = true;
    gman = {
      enable = true;
      # remove conflicts with moonlander
      kanata-keymap.enable = mkForce false;
    };
    gaming.enable = true;
  };

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

  modules = {
    flatpak.enable = true;
    qemu-kvm.enable = true;
    ledger.enable = true;
  };

  programs = {
    cutentr.enable = true;
    prismlauncher = {
      enable = true;
      package = inputs.prismlauncher.packages.${system}.default;
    };
    gparted.enable = true;
    musescore.enable = true;
    lutris.enable = true;
    ardour.enable = true;
    dolphin-emu.enable = true;
    cemu.enable = true;
    mcrcon.enable = true;
    obs-studio.enable = true;
    ryujinx.enable = true;
    # no compatible mouse :(
    piper.enable = false;
    blender.enable = true;
    ani-cli.enable = true;
  };

  # temporary work-around for hjkl arrow navigation
  services = {
    sunshine.enable = true;

    keyd = {
      enable = true;
      keyboards = {
        default = {
          ids = [ "*" ];
          settings = {
            main = {
              leftalt = "layer(nav)";
            };
            "nav:A" = {
              h = "left";
              j = "down";
              k = "up";
              l = "right";
            };
          };
        };
      };
    };
  };

  environment = {
    systemPackages = with pkgs; [
      nixos-generators
      # rojo
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
