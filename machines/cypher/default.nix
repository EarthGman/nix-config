#configurations specific to cypher
{ inputs, outputs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./hardware-configuration.nix
    ./boot.nix
    ./networking.nix
    ../../modules/nixos/virtualization.nix
    ../../modules/nixos/devices.nix
    ../../modules/nixos/desktops.nix
    ../../modules/nixos/common.nix
    ../../modules/nixos/sound.nix
    ../../modules/nixos/fonts.nix
    ../../modules/nixos/printing.nix
    ../../modules/nixos/nix.nix
    ../../modules/nixos/zsh.nix
    ../../modules/nixos/x11-utils.nix
    ../../modules/nixos/amd.nix
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

  # misc
  services.flatpak.enable = true;

  # disables sudo prompting password
  security.sudo.wheelNeedsPassword = false;
}
