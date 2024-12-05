{ pkgs, username, lib, stateVersion, ... }:

# basic wrapper for HM. Shouldn't be edited.
let
  inherit (lib) autoImport;
  programs = autoImport ./modules/home-manager/programs; # anything under the "programs" attribute set or software I define as a program.
  services = autoImport ./modules/home-manager/services; # anything under the "services" attribute set or any added systemd units.
  shared = autoImport ./modules/home-manager/shared; # category consisting of many miscellanous default options and settings.
in
{
  imports = [
    ./modules/home-manager/stylix # default stylix configuration
    ./modules/home-manager/desktop-settings # default configuration for the chosen desktop(s)
    ./profiles/home-manager/${username}.nix # required file! Sets all aspects exclusive to your user accross all machines, EX: git username and email.
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
