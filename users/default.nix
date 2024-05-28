# home.nix equalvalent
{ config, inputs, outputs, username, stateVersion, ... }:
{
  home = {
    inherit username;
    inherit stateVersion;
    homeDirectory = "/home/${username}";
  };
  programs.home-manager.enable = true;

  imports = [
    ./${username}/preferences.nix
    ../modules/home-manager/shells
    ../modules/home-manager/terminals
    ../modules/home-manager/editors
    ../modules/home-manager/desktop-configs
    ../modules/home-manager/browsers
    ../modules/home-manager/common
    ../modules/home-manager/gaming
  ];

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
    };
  };
}
