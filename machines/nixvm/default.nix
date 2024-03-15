{ pkgs, inputs, outputs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./hardware.nix
    ./boot.nix
    ./networking.nix
    ../../modules/nixos/display-managers/sddm
    ../../modules/nixos/desktops
    ../../modules/nixos/desktops/gnome.nix
    ../../modules/nixos/sound.nix
    ../../modules/nixos/nix.nix
    ../../modules/nixos/common.nix
    ../../modules/nixos/fonts.nix
    ../../modules/nixos/zsh.nix
    ../../users/g.nix
  ];
  #loads home-manager
  home-manager.extraSpecialArgs = { inherit inputs outputs; };

  # set deafault desktops
  services.xserver = {
    displayManager = {
      defaultSession = "gnome";
      sddm.theme = "${import ../../modules/nixos/display-managers/sddm/themes/utterly-sweet {inherit pkgs; }}";
    };
  };

  # time zone
  time.timeZone = "America/Chicago";

  #system version
  system.stateVersion = "24.05";

  # disable sudo prompting password
  security.sudo.wheelNeedsPassword = false;
}
