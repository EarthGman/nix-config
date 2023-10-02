#configurations specific to potato
{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../nixos/gnome.nix
    ../../nixos/system-programs.nix
    ../../nixos/sound.nix
    ../../nixos/user-g-settings.nix
    ../../nixos/fonts.nix
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
  boot.kernelParams = [ "video=1366x768" ];
  boot.kernelModules = [
    "kvm-intel"
  ];

  # Grub
  boot.loader = {
    grub = {
      enable = true;
      efiSupport = true;
      devices = [ "nodev" ];
      extraEntries = ''
        menuentry "Reboot" {
          reboot
        }
        menuentry "Poweroff" {
          halt
        }
      '';
    };
    efi.efiSysMountPoint = "/boot";
  };

  #dolphin
  # services.udev.packages = [
  #   pkgs.dolphin-emu

  # ]

  #disables sudo prompting password
  security.sudo.wheelNeedsPassword = false;

  #virtual camera for obs
  boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];

  #networking
  networking.hostName = "potato"; # Define your hostname.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "America/Chicago";

  #enables virtualization
  virtualisation.libvirtd.enable = true;

  #sytsem version
  system.stateVersion = "23.11";
}

