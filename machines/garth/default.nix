#configurations specific to garth
{ inputs, outputs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./hardware.nix
    ./boot.nix
    ./networking.nix
    ../../modules/nixos/virtualization.nix
    ../../modules/nixos/devices.nix
    ../../modules/nixos/display-managers/sddm.nix
    ../../modules/nixos/desktops
    ../../modules/nixos/desktops/cinnamon.nix
    ../../modules/nixos/common.nix
    ../../modules/nixos/sound.nix
    ../../modules/nixos/fonts.nix
    ../../modules/nixos/flatpak.nix
    ../../modules/nixos/printing.nix
    ../../modules/nixos/nix.nix
    ../../modules/nixos/nordvpn.nix
    ../../modules/nixos/zsh.nix
    ../../modules/nixos/x11-utils.nix
    ../../users/g.nix
  ];
  # loads home-manager
  home-manager.extraSpecialArgs = { inherit inputs outputs; };

  # default desktop
  services.xserver.displayManager.defaultSession = "cinnamon";

  # Set your time zone.
  time.timeZone = "America/Chicago";

  #system version
  system.stateVersion = "24.05";

  # disables sudo prompting password
  security.sudo.wheelNeedsPassword = false;
}

