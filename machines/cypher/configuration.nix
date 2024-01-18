#configurations specific to cypher
{ flake-inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./boot.nix
    ./networking.nix
    ../../modules/nixos/virtualization.nix
    ../../modules/nixos/devices.nix
    ../../modules/nixos/cinnamon.nix
    ../../modules/nixos/common.nix
    ../../modules/nixos/sound.nix
    ../../users/g.nix
    ../../modules/nixos/fonts.nix
    ../../modules/nixos/printing.nix
    ../../modules/nixos/nix.nix
    ../../modules/nixos/zsh.nix
    ../../modules/nixos/x11-utils.nix
    ../../modules/nixos/amd.nix
  ];

  # Set your time zone.
  time.timeZone = "America/Chicago";

  #sytsem version
  system.stateVersion = "24.05";

  # misc
  services.nordvpn.enable = true;
  services.flatpak.enable = true;

  # disables sudo prompting password
  security.sudo.wheelNeedsPassword = false;
}
