{ inputs, outputs, config, lib, pkgs, hostName, cpu, username, vm, platform, stateVersion, ... }:
let
  inherit (lib) mkIf mkDefault mkForce genAttrs forEach optionals getExe;
  #TODO auto module importer
in
{
  imports = [
    #temporary
    inputs.disko.nixosModules.disko
    ./${hostName}
    ../modules/nixos/1passwd.nix
    ../modules/nixos/nordvpn.nix
    ../modules/nixos/pipewire.nix
    ../modules/nixos/printing.nix
    ../modules/nixos/sops.nix
    ../modules/nixos/steam.nix
    ../modules/nixos/sunshine.nix
    ../modules/nixos/virtualization.nix
    ../modules/nixos/ssh.nix
    ../modules/nixos/ifuse.nix
    ../modules/nixos/grub.nix
    ../modules/nixos/bluetooth.nix
    ../modules/nixos/nh.nix

    ../modules/nixos/gpu
    ../modules/nixos/display-managers
    ../modules/nixos/desktops
  ];

  custom = {
    ssh.enable = mkDefault true;
  };

  users.users."root".shell = pkgs.zsh;
  users.mutableUsers = mkDefault false;

  hardware = {
    enableRedistributableFirmware = mkDefault true;
    cpu.${cpu}.updateMicrocode = mkIf (vm == "no")
      (mkDefault config.hardware.enableRedistributableFirmware);
  };

  boot = {
    kernelModules = mkIf config.custom.virtualization.enable [ "kvm-${cpu}" ];
    kernelPackages = mkDefault pkgs.linuxPackages_latest;
  };

  networking = {
    # forces wireless off since I use networkmanager for all systems
    wireless.enable = mkForce false;
    inherit hostName;
    networkmanager.enable = true;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs = {
    overlays = (builtins.attrValues outputs.overlays);
    config.allowUnfree = true;
    hostPlatform = platform;
  };

  time.timeZone = mkDefault "America/Chicago";
  system = {
    inherit stateVersion;
  };

  # packages that will be installed on all systems: desktop, server, iso 
  environment.systemPackages = with pkgs; [
    btop
    powertop
    sysz
    git
    file
    ncdu
    zip
    unzip
    usbutils
    pciutils
    lshw
    fd
    lynx
    zoxide # must be on path
  ];

  # root level shell
  programs.zsh = {
    enable = true;
    shellAliases = {
      l = "ls -al";
      g = "${getExe pkgs.git}";
      t = "${getExe pkgs.tree}";
      ga = "g add .";
      gco = "g checkout";
      gba = "g branch -a";
      cat = "${getExe pkgs.bat}";
      nrs = "${getExe pkgs.nh} os switch $(readlink -f /etc/nixos)";
      nrt = "${getExe pkgs.nh} os test $(readlink -f /etc/nixos)";
      ncg = "${getExe pkgs.nh} clean all";
    };
    promptInit = ''
      eval "$(${getExe pkgs.zoxide} init --cmd j zsh)"
      export EDITOR=nano
    '';
  };
}
