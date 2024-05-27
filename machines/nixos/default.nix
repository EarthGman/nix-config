{ config, desktop, displayManager, hostname, inputs, lib, modulesPath, outputs, pkgs, platform, stateVersion, username, ... }:
let
  hasDesktop = if (desktop != null) then true else false;
  timezone = "America/Chicago";
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
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    # users = {
    #   g = import ./home.nix;
    # };
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  time.timeZone = timezone;
  system.stateVersion = stateVersion;
}
