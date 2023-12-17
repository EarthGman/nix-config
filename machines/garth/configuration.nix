#configurations specific to garth
{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/gnome.nix
    ../../modules/nixos/system-programs.nix
    ../../modules/nixos/sound.nix
    ../../users/g.nix
    ../../modules/nixos/fonts.nix
    ../../modules/nixos/printing.nix
    ../../modules/nixos/wine.nix
    ../../modules/nixos/virtualization.nix
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

  ];
  boot.kernelModules = [
    "kvm-intel"
  ];

  #boot - systemd
  boot.loader.systemd-boot.enable = true;
  boot.loader = {
    efi.canTouchEfiVariables = true;
    efi.efiSysMountPoint = "/boot";
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
      hostName = "garth"; # Define your hostname.
      networkmanager.enable = true; # Easiest to use and most distros use this by default.
      firewall = {
        checkReversePath = false;
        allowedTCPPorts = [
          22 # SSHD tellnet port
          443 # TLS/SSL listen port
        ];
        allowedUDPPorts = [
          1194 # openvpn listen port
          5353 # printer discovery port
        ];
      };
    };
}
