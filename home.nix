{ pkgs, username, myLib, hostName, stateVersion, ... }:

let
  programs = myLib.autoImport ./modules/home-manager/programs;
in
{
  imports = [
    ./modules/home-manager/common.nix
    ./modules/home-manager/stylix
    ./modules/home-manager/desktop-configs
    ./hosts/${hostName}/users/${username}/preferences.nix
  ] ++ programs;

  programs.home-manager.enable = true;

  home = {
    packages = [ pkgs.home-manager ];
    inherit username stateVersion;
    homeDirectory = "/home/${username}";
  };
}
