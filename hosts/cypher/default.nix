{
  inputs,
  pkgs,
  config,
  ...
}:
{
  imports = [
    ./sddm.nix
    ./disko.nix
  ];

  time.timeZone = "America/Chicago";

  gman = {
    qemu-kvm.enable = true;
    # conflicts with zsa moonlander
    kanata.enable = false;
    earthgman.enable = true;
    steam.enable = true;
    hacker-mode.enable = true;
  };

  networking.firewall = {
    allowedTCPPorts = [ 22000 ];
    allowedUDPPorts = [
      22000
      21027
    ];
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

  # setup iommu passthrough for the integrated gpu
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

  # extra drive for steam library and others
  fileSystems."/home/g/games" = {
    device = "/dev/disk/by-label/games";
    fsType = "ext4";
  };

  # boot.binfmt.emulatedSystems = [
  #   "aarch64-linux"
  # ];

  hardware = {
    # davinci resolve dependency for amd gpus
    amdgpu.opencl.enable = true;

    # bitcoin
    ledger.enable = true;
  };

  networking = {
    # required for sins of a solar empire lag bug in multiplayer
    extraHosts = ''66.79.209.80 ico-reb.stardock.com'';
  };

  programs = {
    cutentr.enable = true;
    bottles.enable = true;
    filezilla.enable = true;
    gimp.enable = true;
    prismlauncher = {
      enable = true;
      # newest version of prism
      package = inputs.prismlauncher.packages.${config.meta.system}.default;
    };
    gnome-software.enable = true;
    musescore.enable = true;
    lutris.enable = true;
    ledger-live-desktop.enable = true;
    ardour.enable = true;
    dolphin-emu.enable = true;
    cemu.enable = true;
    mcrcon.enable = true;
    obs-studio.enable = true;
    ryubing.enable = true;
    # no compatible mouse :(
    piper.enable = false;
    blender.enable = true;
    ani-cli.enable = true;
  };

  services = {
    # for vinegar and sober (roblox) un-sandboxed doesn't work well
    flatpak.enable = true;

    # remote desktop
    sunshine = {
      enable = true;
      openFirewall = true;
      capSysAdmin = true;
    };

    # TODO: temporary work-around for hjkl arrow navigation on zsa moonlander
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
