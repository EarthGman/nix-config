{ self, inputs, outputs, config, lib, desktop, myLib, pkgs, hostName, cpu, username, vm, platform, stateVersion, ... }:
let
  inherit (lib) mkIf mkDefault genAttrs forEach optionals getExe;
  #TODO auto module importer
in
{
  imports = [
    #temporary
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

    ../modules/nixos/gpu
    ../modules/nixos/display-managers
    ../modules/nixos/desktops

    inputs.disko.nixosModules.disko
    inputs.home-manager.nixosModules.default
    ./${hostName}
    ./${hostName}/users/${username}
  ];

  # creates a home manager config for every user specificed in users string
  # home-manager = {
  #   users = genAttrs usernames (username:
  #     import ../home.nix { inherit username outputs pkgs lib stateVersion; });
  home-manager = {
    users.g = import ../home.nix;
    extraSpecialArgs = {
      inherit self inputs outputs hostName username desktop myLib stateVersion;
    };
  };

  custom = {
    ssh.enable = mkDefault true;
  };

  users.users."root".shell = pkgs.zsh;
  users.mutableUsers = mkDefault false;

  hardware = {
    enableRedistributableFirmware = lib.mkDefault true;
    cpu.${cpu}.updateMicrocode = mkIf (vm == "no")
      (mkDefault config.hardware.enableRedistributableFirmware);
  };

  boot = {
    kernelModules = mkIf ((vm == "no") && config.custom.virtualization.enable) [ "kvm-${cpu}" ];
    kernelPackages = mkDefault pkgs.linuxPackages_latest;
  };

  networking = {
    inherit hostName;
    networkmanager.enable = true;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs = {
    overlays = (builtins.attrValues outputs.overlays);
    config.allowUnfree = true;
    hostPlatform = platform;
  };

  # better nix cli
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
  };

  time.timeZone = mkDefault "America/Chicago";
  system = {
    inherit stateVersion;
  };

  # packages that will be installed on all systems: desktop, server, iso 
  environment.systemPackages = with pkgs; [
    btop
    sysz
    git
    #disko
    file
    zip
    unzip
    usbutils
    pciutils
    lshw
    fd
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
      export EDITOR=${config.home-manager.users.${username}.preferredEditor}
    '';
  };
}
