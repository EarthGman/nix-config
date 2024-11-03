{ pkgs, username, myLib, hostName, stateVersion, ... }:

let
  inherit (myLib) autoImport;
  programs = autoImport ./modules/home-manager/programs;
  services = autoImport ./modules/home-manager/services;
  shared = autoImport ./modules/home-manager/shared;
in
{
  imports = [
    ./modules/home-manager/stylix
    ./modules/home-manager/desktop-settings
    ./hosts/${hostName}/users/${username}/preferences.nix
  ]
  ++ shared
  ++ programs
  ++ services;

  programs.home-manager.enable = true;

  home = {
    packages = [ pkgs.home-manager ];
    inherit username stateVersion;
    homeDirectory = "/home/${username}";
  };
}
