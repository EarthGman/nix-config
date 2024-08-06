{ pkgs, config, lib, desktop, hostname, cpu, inputs, modulesPath, stateVersion, gpu, platform, ... }:
let
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
  ] ++ lib.optionals (isServer) [
    ../templates/prox-server
  ] ++ lib.optionals (hasDesktop) [
    ../templates/desktop
    ../modules/nixos/desktops
    ../modules/nixos/display-managers
  ] ++ lib.optionals (hasGPU) [
    ../modules/nixos/gpudrivers
  ] ++ lib.optionals (!isVM) [
    (modulesPath + "/installer/scan/not-detected.nix")
    ../modules/nixos/virtualization.nix
  ] ++ lib.optionals (isVM) [
    (modulesPath + "/profiles/qemu-guest.nix")
  ] ++ lib.optionals (hasSecrets) [
    ../modules/nixos/sops.nix
  ];

  hardware.cpu.${cpu}.updateMicrocode = lib.mkIf (!isVM) (lib.mkDefault config.hardware.enableRedistributableFirmware);

  boot = {
    kernelModules = if (isVM) then [ ] else if (cpu == "intel") then [ "kvm-intel" ] else [ "kvm-amd" ];
    kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;
  };

  networking.useDHCP = lib.mkDefault true;
  users.mutableUsers = lib.mkDefault false;
  time.timeZone = lib.mkDefault "America/Chicago";
  system.stateVersion = stateVersion;

  users.users."root" = {
    shell = pkgs.zsh;
  };
}
