#configurations specific to garth
{ flake-inputs, config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./boot.nix
    ./devices.nix
    ./networking.nix
    ../../modules/nixos/gnome.nix
    ../../modules/nixos/system-programs.nix
    ../../modules/nixos/sound.nix
    ../../users/g.nix
    ../../modules/nixos/fonts.nix
    ../../modules/nixos/printing.nix
    ../../modules/nixos/wine.nix
    ../../modules/nixos/virtualization.nix
    ../../modules/nixos/nix.nix
    ../../modules/nixos/zsh.nix
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
