{ pkgs, config, lib, desktop, hostname, cpu, inputs, modulesPath, stateVersion, timezone, gpu, platform, ... }:
let
  hasDesktop = (desktop != null);
  hasGPU = (gpu != null);
  hasNord = (hostname == "cypher" || hostname == "garth");
  isGamingPC = (hostname == "cypher" || hostname == "garth" || hostname == "somnus" || hostname == "cutlass");
  hasOnePassword = (hostname == "cypher" || hostname == "garth" || hostname == "tater");
  isISO = (builtins.substring 0 4 hostname == "iso-");
  isServer = builtins.substring 0 7 hostname == "server-";
  isVM = (hostname == "nixos" || isServer);
  hasSecrets = builtins.pathExists ../secrets/${hostname}.yaml;
in
{
  imports = [
    inputs.disko.nixosModules.disko
    ./${hostname}
    ../modules/nixos/packages.nix
    ../modules/nixos/nix.nix
  ] ++ lib.optionals (isServer) [
    ../templates/prox-server
  ] ++ lib.optionals (hasNord) [
    ../modules/nixos/nordvpn
  ] ++ lib.optionals (hasOnePassword) [
    ../modules/nixos/1passwd.nix
  ] ++ lib.optionals (hasDesktop) [
    ../templates/desktop
    ../modules/nixos/desktops
    ../modules/nixos/display-managers
  ] ++ lib.optionals (isGamingPC) [
    ../modules/nixos/steam.nix
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

  boot.kernelModules = if (isVM) then [ ] else if (cpu == "intel") then [ "kvm-intel" ] else [ "kvm-amd" ];

  networking.useDHCP = lib.mkDefault true;
  users.mutableUsers = lib.mkDefault false;
  time.timeZone = timezone;
  system.stateVersion = stateVersion;
}
