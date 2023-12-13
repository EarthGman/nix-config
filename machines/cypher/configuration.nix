#configurations specific to cypher
{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../nixos/gnome.nix
    ../../nixos/system-programs.nix
    ../../nixos/sound.nix
    ../../nixos/user-g-settings.nix
    ../../nixos/fonts.nix
    ../../nixos/wine.nix
    ./nvidia.nix
    #./amd.nix
  ];

  # Set your time zone.
  time.timeZone = "America/Chicago";

  #sytsem version
  system.stateVersion = "23.11";

  # package settings
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnsupportedSystem = true;
    };
  };
  nixpkgs.config.packageOverrides = pkgs: {
    # nord
    nordvpn = config.nur.repos.LuisChDev.nordvpn;
  };

  # Enable Nix Flakes
  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];

    settings.auto-optimise-store = true;
  };

  #latest linux kernel
  boot.kernelPackages = pkgs.linuxPackages_6_5;

  boot.kernelParams = [
    "video=1920x1080"
    "intel_iommu=on"
    "iommu=pt"
  ];
  boot.kernelModules = [
    "vfio_virqfd"
    "vfio_pci"
    "vfio_iommu_type1"
    "vfio"
    "kvm-intel"
  ];
  boot.blacklistedKernelModules = [ "coffeelake" "nouveau" ];
  boot.extraModprobeConfig = "options vfio-pci ids=8086:3e92,8086:a348";

  #boot - grub 2
  #boot.loader.systemd-boot.enable = true;
  boot.loader = {
    efi.canTouchEfiVariables = true;
    efi.efiSysMountPoint = "/boot";
    grub.enable = true;
    grub.efiSupport = true;
    #grub.useOSProber = true;
    grub.devices = [ "nodev" ];
    grub.extraEntries = ''
      menuentry 'Windows 10' --class windows --class os {
        insmod part_gpt
        insmod ntfs
        search --no-floppy --fs-uuid --set=root 42AD-8EF4
        chainloader /efi/Microsoft/Boot/bootmgfw.efi
      }
      menuentry "Reboot" {
        reboot
      }
      menuentry "Poweroff" {
        halt
      }
    '';
    timeout = 5;
  };

  # printing
  # searches the network for printers
  services.avahi = {
    enable = true;
    nssmdns = true;
    openFirewall = true;
  };
  services.printing = {
    enable = true;
    drivers = [
      pkgs.samsung-unified-linux-driver
    ];
  };
  hardware.printers = {
    ensurePrinters = [
      {
        # printer downstairs
        name = "SamsungCLX3175FW";
        location = "Home";
        deviceUri = "http://192.168.72.21:631";
        model = "samsung/CLX-3170.ppd";
        ppdOptions = {
          PageSize = "Letter";
        };
      }
    ];
    ensureDefaultPrinter = "SamsungCLX3175FW";
  };

  # misc
  services.nordvpn.enable = true;
  services.flatpak.enable = true;

  services.udev.packages = [ pkgs.dolphinEmu ];
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTRS{idVendor}=="0079", ATTRS{idProduct}=="0006", MODE="0666"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="0079", ATTRS{idProduct}=="1846", MODE="0666"
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="0306", MODE="0666"
  '';

  # disables sudo prompting password
  security.sudo.wheelNeedsPassword = false;

  # virtual camera for obs
  boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];

  # networking
  services.sshd = {
    enable = true;
  };
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = true;
  };
  # enables openVpn to resolve DNS hostnames
  services.resolved.enable = true;
  networking =
    {
      hostName = "cypher"; # Define your hostname.
      networkmanager.enable = true; # Easiest to use and most distros use this by default.
      firewall = {
        checkReversePath = false;
        allowedTCPPorts = [
          22 # SSHD tellnet port
          443 # TLS/SSL listen port
        ];
        allowedUDPPorts = [
          1194 # openvpn listen port
          5353 # printer disovery port
        ];
      };
    };

  # enables virtualization
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        ovmf.enable = true;
        swtpm.enable = true;
      };
    };
  };
}


