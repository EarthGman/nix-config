# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ inputs, outputs, config, lib, myLib, pkgs, hostname, users, platform, stateVersion, ... }:
let
  usernames = myLib.splitToList users;
in
{
  imports = [
    inputs.disko.nixosModules.disko
    inputs.home-manager.nixosModules.default
    ./disko.nix
    ./hardware-configuration.nix
  ];

  #boot.loader.systemd-boot.enable = true;
  boot.kernelPackages = pkgs.linuxPackages_6_10;
  boot.extraModulePackages = with pkgs; [
    linuxKernel.packages.linux_6_10.broadcom_sta
  ];
  boot.kernelModules = [ "wl" ];
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    devices = [ "nodev" ];
    gfxmodeEfi = "1920x1080";
  };
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = hostname; # Define your hostname.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  time.timeZone = "America/Chicago";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.overlays = (builtins.attrValues outputs.overlays);
  nixpkgs.config.allowUnfree = true;
  nixpkgs.hostPlatform = platform;

  # creates a home manager config for every user specificed in users string
  home-manager.users = lib.genAttrs usernames (username:
    import ./home.nix { inherit username outputs pkgs lib stateVersion; });

  # home-manager.users.g = import ./home.nix { inherit outputs lib stateVersion; };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.windowManager.i3.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal ];
  xdg.portal.configPackages = [ pkgs.xdg-desktop-portal ];
  # Configure keymap in X11
  services.xserver.xkb.layout = "us";
  services.xserver.excludePackages = with pkgs; [ xterm ];
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # hardware.pulseaudio.enable = true;
  # OR
  # services.pipewire = {
  #   enable = true;
  #   pulse.enable = true;
  # };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.g = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
    hashedPassword = "$y$j9T$7tYxxNPgxLhrPDjHKj8nh/$8YcqgeeJMWnXGVP9VH0Tnzf/rkeWMZJ6VRZIWSEan94";
  };

  users.users."root".shell = pkgs.zsh;

  users.mutableUsers = false;

  # packages that will be installed on all systems: desktop, server, iso 
  environment.systemPackages = with pkgs; [
    btop
    sysz
    git
    disko
    file
    zip
    unzip
    usbutils
    pciutils
    lshw
    fd
    steam-run
  ];

  # root level shell
  programs.zsh = {
    enable = true;
    enableCompletion = lib.mkDefault true;
    syntaxHighlighting.enable = lib.mkDefault true;
    shellAliases = {
      l = "ls -al";
      g = "${lib.getExe pkgs.git}";
      t = "${lib.getExe pkgs.tree}";
      ga = "g add .";
      gco = "g checkout";
      gba = "g branch -a";
      cat = "${lib.getExe pkgs.bat}";
    };
  };
  programs.starship.enable = lib.mkDefault true;
  programs.direnv.enable = lib.mkDefault true;
  programs.direnv.nix-direnv.enable = lib.mkDefault true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = stateVersion;
}
