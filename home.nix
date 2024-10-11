{ pkgs, username, myLib, hostName, stateVersion, ... }:

let
  inherit (myLib) autoImport;
  programs = autoImport ./modules/home-manager/programs;
  services = autoImport ./modules/home-manager/services;
in
{
  imports = [
    ./modules/home-manager/shared.nix
    ./modules/home-manager/stylix
    ./modules/home-manager/desktop-settings
    ./hosts/${hostName}/users/${username}/preferences.nix
  ]
  ++ programs
  ++ services;

  programs.home-manager.enable = true;

  home = {
    packages = [ pkgs.home-manager ];
    inherit username stateVersion;
    homeDirectory = "/home/${username}";
  };
}
