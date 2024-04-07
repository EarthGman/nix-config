#configurations specific to tater
{pkgs, inputs, outputs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./hardware.nix
    ./boot.nix
    ./networking.nix
    ../../modules/nixos/virtualization.nix
    ../../modules/nixos/desktops
    ../../modules/nixos/desktops/cinnamon.nix
    ../../modules/nixos/display-managers/sddm
    ../../modules/nixos/common.nix
    ../../modules/nixos/sound.nix
    ../../modules/nixos/flatpak.nix
    ../../modules/nixos/fonts.nix
    ../../modules/nixos/printing.nix
    ../../modules/nixos/nix.nix
    ../../modules/nixos/zsh.nix
    ../../modules/nixos/x11-utils.nix
    ../../users/g.nix
  ];
  # loads home-manager
  home-manager.extraSpecialArgs = { inherit inputs outputs; };

  # set default desktops
  services.xserver = {
    displayManager = {
      defaultSession = "cinnamon";
      sddm.theme = "${import ../../modules/nixos/display-managers/sddm/themes/hallow-knight {inherit pkgs; }}";
    };
  };

  # Set your time zone.
  time.timeZone = "America/Chicago";

  #system version
  system.stateVersion = "24.05";

  # sudo prompting password
  security.sudo.wheelNeedsPassword = false;
}

