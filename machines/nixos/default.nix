{ config, desktop, displayManager, hostname, inputs, lib, modulesPath, outputs, pkgs, platform, stateVersion, timezone, username, gpu, ... }:
let
  hasDesktop = if (desktop != null) then true else false;
  hasGPU = if (gpu != null) then true else false;
  # hasNord = if (hostname == "cypher" || hostname == "garth") then true else false;
in
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./hardware.nix
    ./boot.nix
    ./networking.nix
    ../../modules/nixos/users
    ../../modules/nixos/common
    #../../modules/nixos/nordvpn
  ] ++ lib.optionals (hasDesktop) [
    ../../modules/nixos/desktops
    ../../modules/nixos/display-managers
  ] ++ lib.optionals (hasGPU) [
    ./../modules/nixos/gpudrivers
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
  };

  time.timeZone = timezone;
  system.stateVersion = stateVersion;
}
