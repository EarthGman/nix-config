{ pkgs, username, myLib, stateVersion, ... }:

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
    ./profiles/home-manager/${username}.nix
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
