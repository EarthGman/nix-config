{ inputs, outputs, config, lib, myLib, pkgs, hostName, cpu, vm, platform, stateVersion, ... }:
let
  inherit (lib) mkIf mkDefault mkForce getExe;
  nixosModules = myLib.autoImport ../modules/nixos;

  hasUser = (builtins.pathExists ./${hostName}/users);
  nixosUsers =
    if hasUser
    then
      myLib.autoImport ./${hostName}/users
    else [ ];
in
{
  imports = [
    inputs.disko.nixosModules.disko
    ./${hostName}
  ]
  ++ nixosModules
  ++ nixosUsers;


  custom = {
    ssh.enable = mkDefault true;
    nh.enable = mkDefault true;
  };

  users.users."root".shell = pkgs.zsh;
  users.mutableUsers = mkDefault false;

  hardware = {
    enableRedistributableFirmware = mkDefault true;
    cpu.${cpu}.updateMicrocode = mkIf (vm == "no")
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
    hstr
    zip
    unzip
    usbutils
    pciutils
    lshw
    fd
    lynx
    ripgrep
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
      nrb = "nixos-rebuild build";
      ncg = "${getExe pkgs.nh} clean all";
    };

    #TODO export EDITOR=neovim once learned
    promptInit = ''
      eval "$(${getExe pkgs.zoxide} init --cmd j zsh)"
      export EDITOR=nvim
    '';
  };
  # enable starship for everyone
  programs.starship.enable = mkDefault true;

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };
}
