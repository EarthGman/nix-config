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
    ./nvidia.nix
  ];

  # Allow unfree packages
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnsupportedSystem = true;
    };
  };

  # Enable Nix Flakes
  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];

    settings.auto-optimise-store = true;
  };

  #latest linux kernel
  boot.kernelPackages = pkgs.linuxPackages_6_5;
  #linux kernel boots in this resolution
  boot.kernelParams = [ "video=1920x1080" "intel_iommu=on" ];
  boot.kernelModules = [

    "kvm-intel"
  ];

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

  nixpkgs.config.packageOverrides = pkgs: {
    # nord
    nordvpn = config.nur.repos.LuisChDev.nordvpn;
  };

  #services
  services.nordvpn.enable = true;
  services.flatpak.enable = true;

  #dolphin
  services.udev.packages = [ pkgs.dolphinEmu ];
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTRS{idVendor}=="0079", ATTRS{idProduct}=="0006", MODE="0666"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="0079", ATTRS{idProduct}=="1846", MODE="0666"
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="0306", MODE="0666"
  '';

  #disables sudo prompting password
  security.sudo.wheelNeedsPassword = false;

  #virtual camera for obs
  boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];

  #networking
  networking =
    {
      hostName = "cypher"; # Define your hostname.
      networkmanager.enable = true; # Easiest to use and most distros use this by default.
      firewall = {
        checkReversePath = false;
        allowedTCPPorts = [
          443 #TLS/SSL listen port
        ];
        allowedUDPPorts = [
          1194 #Openvpn listen port
        ];
      };
    };


  # Set your time zone.
  time.timeZone = "America/Chicago";

  #enables virtualization
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        ovmf.enable = true;
        swtpm.enable = true;
      };
    };
  };

  #sytsem version
  system.stateVersion = "23.11";
}
