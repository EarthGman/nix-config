# home-manager wrapper
{ config, inputs, outputs, username, hostname, stateVersion, ... }:
{
  home = {
    inherit username;
    inherit stateVersion;
    homeDirectory = "/home/${username}";
  };
  programs.home-manager.enable = true;

  imports = [
    ./hosts/${hostname}/users/${username}/preferences.nix
    ./modules/home-manager/apps
    ./modules/home-manager/browsers
    ./modules/home-manager/common
    ./modules/home-manager/desktop-configs
    ./modules/home-manager/editors
    ./modules/home-manager/gaming
    ./modules/home-manager/shells
    ./modules/home-manager/stylix
    ./modules/home-manager/terminals
    ./modules/home-manager/wine
  ];

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
    };
  };
}
