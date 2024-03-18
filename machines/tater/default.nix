#configurations specific to tater
{ inputs, outputs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./hardware.nix
    ./boot.nix
    ./networking.nix
    ../../modules/nixos/virtualization.nix
    ../../modules/nixos/desktops
    ../../modules/nixos/display-managers/sddm
    ../../modules/nixos/cinnamon.nix
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
      sddm.theme = "${import ../../modules/nixos/display-managers/sddm/themes/bluish-sddm {inherit pkgs; }}";
    };
  };

  # Set your time zone.
  time.timeZone = "America/Chicago";

  #system version
  system.stateVersion = "24.05";

  # disables sudo prompting password
  security.sudo.wheelNeedsPassword = false;
}

