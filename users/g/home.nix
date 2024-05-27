{ config, inputs, username, stateVersion, ... }:
{
  home = {
    inherit username;
    inherit stateVersion;
    homeDirectory = "/home/${username}";
  };
  programs.home-manager.enable = true;

  imports = [
    ./home-config.nix
    ../../modules/home-manager/shells
    ../../modules/home-manager/terminals
    ../../modules/home-manager/editors
    ../../modules/home-manager/desktop-configs
    ../../modules/home-manager/browsers
    ../../modules/home-manager/common
    ../../modules/home-manager/gaming
  ];

  # allows home-manager to install unfree packages from nur
  nixpkgs = {
    overlays = [
      inputs.nur.overlay
      # (final: _: {
      #   unstable = import inputs.nixpkgs-unstable {
      #     inherit (final) system;
      #     config.allowUnfree = true;
      #   };
      # })
    ];
    config = {
      allowUnfree = true;
    };
  };
}
