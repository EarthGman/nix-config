{ pkgs, desktop, hostname, inputs, lib, modulesPath, stateVersion, timezone, gpu, platform, ... }:
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
    ./${hostname}
    ../modules/nixos/nix.nix
    ../modules/nixos/packages.nix
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
    ../modules/nixos/virtualization.nix
  ] ++ lib.optionals (hasSecrets) [
    ../modules/nixos/sops.nix
  ];

  users.mutableUsers = lib.mkDefault false;
  time.timeZone = timezone;
  system.stateVersion = stateVersion;
}
