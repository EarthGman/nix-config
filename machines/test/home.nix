{ config, inputs, ... }:
{
  home = {
    username = "g";
    homeDirectory = "/home/g";
    stateVersion = "24.05";
    sessionVariables = {
      EDITOR = "code --wait";
    };
  };
  programs.home-manager.enable = true;

  imports = [
    ../../modules/home-manager/shells
    ../../modules/home-manager/editors
    ../../modules/home-manager/terminals
    ../../modules/home-manager/desktop-configs
    ../../modules/home-manager/browsers
    ../../modules/home-manager/common
    ../../modules/home-manager/gaming
  ];

  # allows home-manager to install unfree packages from nur
  nixpkgs = {
    overlays = [
      inputs.nur.overlay
    ];
    config = {
      allowUnfree = true;
    };
  };
}
