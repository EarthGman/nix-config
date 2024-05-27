{ config, desktop, displayManager, hostname, inputs, lib, modulesPath, outputs, pkgs, platform, stateVersion, timezone, username, gpu, ... }:
let
  hasDesktop = if (desktop != null) then true else false;
  hasGPU = if (gpu != null) then true else false;
  hasNord = if (hostname == "cypher" || hostname == "garth") then true else false;
in
{
  imports = [
    ./${hostname}
    ../users/${username}
    ../modules/nixos/common
  ] ++ lib.optionals (hasNord) [
    ../modules/nixos/nordvpn
  ] ++ lib.optionals (hasDesktop) [
    ../modules/nixos/desktops
    ../modules/nixos/display-managers
  ] ++ lib.optionals (hasGPU) [
    ../modules/nixos/gpudrivers
  ];

  time.timeZone = timezone;
  system.stateVersion = stateVersion;
}
