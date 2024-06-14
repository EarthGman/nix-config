{ config, desktop, displayManager, hostname, inputs, lib, modulesPath, outputs, platform, stateVersion, timezone, gpu, ... }:
let
  hasDesktop = (desktop != null);
  hasGPU = (gpu != null);
  hasNord = (hostname == "cypher" || hostname == "garth");
  isISO = (builtins.substring 0 4 hostname == "iso-");
in
{
  imports = [
    # inputs.stylix.nixosModules.stylix
    ./${hostname}
  ] ++ lib.optionals (!isISO) [
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
