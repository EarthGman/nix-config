{ inputs, outputs, pkgs, lib, config, hostName, cpu, vm, system, stateVersion, ... }:
let
  inherit (lib) mkDefault mkIf mkForce;
in
{
  imports = [
    inputs.disko.nixosModules.disko
  ];

  modules = {
    direnv.enable = mkDefault true;
    ssh.enable = mkDefault true;
    nh.enable = mkDefault true;
  };

  documentation.nixos.enable = mkDefault false;

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
    wireless.enable = mkForce false;
    inherit hostName;
    networkmanager.enable = true;
  };

  nix = {
    channel.enable = mkDefault false; # causes a weird error about symlinks being present just rm them manually and it goes away 
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
  };

  nixpkgs = {
    overlays = (builtins.attrValues outputs.overlays);
    config.allowUnfree = true;
    hostPlatform = "${system}";
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
    neovim-custom = {
      enable = mkDefault true;
      viAlias = mkDefault true;
      vimAlias = mkDefault true;
      defaultEditor = mkDefault true;
    };
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
