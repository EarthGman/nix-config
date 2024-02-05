#configurations specific to garth
{ flake-inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./boot.nix
    ./networking.nix
    ../../modules/nixos/virtualization.nix
    ../../modules/nixos/devices.nix
    ../../modules/nixos/desktops.nix
    ../../modules/nixos/common.nix
    ../../modules/nixos/sound.nix
    ../../users/g.nix
    ../../modules/nixos/fonts.nix
    ../../modules/nixos/printing.nix
    ../../modules/nixos/nix.nix
    ../../modules/nixos/zsh.nix
    ../../modules/nixos/x11-utils.nix
  ];

  #default desktop
  services.xserver.displayManager.defaultSession = "cinnamon";

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
