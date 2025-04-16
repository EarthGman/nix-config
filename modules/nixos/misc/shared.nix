{ inputs, outputs, pkgs, lib, config, hostName, cpu, vm, platform, stateVersion, ... }:
let
  inherit (lib) mkDefault mkIf optionals mkForce getExe optionalString;
in
{
  imports = [
    inputs.disko.nixosModules.disko
  ];

  # default profile for all machines
  modules = {
    direnv.enable = mkDefault true;
    ssh.enable = mkDefault true;
    nh.enable = mkDefault true;
  };


  # goodbye bloat
  documentation.nixos.enable = mkDefault false;

  # other module boilerplate, applied by default to all configurations
  users.users."root".shell = pkgs.zsh;
  users.mutableUsers = mkDefault false;

  hardware = {
    enableRedistributableFirmware = mkDefault true;
    cpu.${cpu}.updateMicrocode = mkIf (!vm)
      (mkDefault config.hardware.enableRedistributableFirmware);
  };

  boot = {
    kernelPackages = mkDefault pkgs.linuxPackages_latest;
  };

  networking = {
    # forces wireless off since I use networkmanager for all systems
    wireless.enable = mkForce false;
    inherit hostName;
    networkmanager.enable = true;
  };

  nix = {
    channel.enable = mkDefault false; # please just use flakes instead
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
  };

  nixpkgs = {
    overlays = (builtins.attrValues outputs.overlays);
    config.allowUnfree = true;
    hostPlatform = platform;
  };

  time.timeZone = mkDefault "America/Chicago";
  system = {
    inherit stateVersion;
  };

  environment.systemPackages =
    with pkgs; [
      btop
      efibootmgr
      powertop
      fzf
      sysz
      file
      cifs-utils
      ncdu
      nix-prefetch-git
      hstr
      inxi
      psmisc
      zip
      unzip
      usbutils
      pciutils
      lshw
      lsof
      fd
      jq
      tldr
      lynx
      ripgrep
    ];

  programs = {
    yazi.enable = mkDefault true;
    neovim-custom.enable = mkDefault true;
    lazygit.enable = mkDefault true;
    tmux.enable = mkDefault true;
    starship.enable = mkDefault true;
    bat.enable = mkDefault true;
    zsh.enable = mkDefault true;
    zoxide = {
      enable = mkDefault true;
      flags = mkDefault [
        "--cmd j"
      ];
    };
  };
}
