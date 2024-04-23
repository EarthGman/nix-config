# nixos configurations specific to cypher
{ pkgs, inputs, outputs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./hardware.nix
    ./boot.nix
    ./networking.nix
    ../../modules/nixos/drivers/amd.nix
    ../../modules/nixos/display-managers/sddm
    ../../modules/nixos/desktops
    ../../modules/nixos/nordvpn
    ../../modules/nixos/desktops/gnome.nix
    ../../modules/nixos/desktops/cinnamon.nix
    ../../modules/nixos/devices.nix
    ../../modules/nixos/virtualization.nix
    ../../modules/nixos/sound.nix
    ../../modules/nixos/nix.nix
    ../../modules/nixos/flatpak.nix
    ../../modules/nixos/common.nix
    ../../modules/nixos/fonts.nix
    ../../modules/nixos/printing.nix
    ../../modules/nixos/zsh.nix
    ../../modules/nixos/x11-utils.nix
    ../../users/g.nix
  ];
  # loads home-manager
  home-manager.extraSpecialArgs = { inherit inputs outputs; };

  # default desktop
  services = {
    displayManager = {
      defaultSession = "cinnamon";
      sddm.theme = "${import ../../modules/nixos/display-managers/sddm/themes/utterly-sweet {inherit pkgs; }}";
    };
  };

  # Set your time zone.
  time.timeZone = "America/Chicago";

  #system version
  system.stateVersion = "24.05";

  # sudo prompting password
  security.sudo.wheelNeedsPassword = true;
}
