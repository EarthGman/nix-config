{ pkgs, config, lib, desktop, hostname, cpu, inputs, modulesPath, stateVersion, gpu, platform, ... }:
let
  inherit (lib) mkIf mkDefault optionals;
  hasDesktop = (desktop != null);
  hasGPU = (gpu != null);
  isISO = (builtins.substring 0 4 hostname == "iso-");
  isServer = builtins.substring 0 7 hostname == "server-";
  isVM = (hostname == "nixos" || isServer);
  hasSecrets = builtins.pathExists ../secrets/${hostname}.yaml;
in
{
  imports = [
    inputs.disko.nixosModules.disko
    ./${hostname}
    ../modules/nixos/steam.nix
    ../modules/nixos/packages.nix
    ../modules/nixos/nix.nix
    ../modules/nixos/neovim.nix
    ../modules/nixos/nordvpn.nix
    ../modules/nixos/1passwd.nix
    ../modules/nixos/sunshine.nix
    ../modules/nixos/polkit.nix
    ../modules/nixos/virtualization.nix
    ../modules/nixos/sops.nix
  ] ++ optionals (isServer) [
    ../templates/prox-server
  ] ++ optionals (hasDesktop) [
    ../templates/desktop
    ../modules/nixos/desktops
    ../modules/nixos/display-managers
  ] ++ optionals (hasGPU) [
    ../modules/nixos/gpudrivers
  ] ++ optionals (!isVM) [
    (modulesPath + "/installer/scan/not-detected.nix")
  ] ++ optionals (isVM) [
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  hardware.cpu.${cpu}.updateMicrocode = mkIf (!isVM) (mkDefault config.hardware.enableRedistributableFirmware);

  boot = {
    kernelModules = mkIf ((!isVM) && config.custom.virtualization.enable) [ "kvm-${cpu}" ];
    kernelPackages = mkDefault pkgs.linuxPackages_latest;
  };

  custom = {
    virtualization.enable = mkDefault (!isVM);
    polkit.enable = mkDefault true;
    sops-nix.enable = hasSecrets;
  };

  networking.useDHCP = mkDefault true;
  users.mutableUsers = mkDefault false;
  time.timeZone = mkDefault "America/Chicago";
  system.stateVersion = stateVersion;

  users.users."root" = {
    shell = pkgs.zsh;
  };
}
