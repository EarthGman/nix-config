# home-manager wrapper
{ outputs, lib, username, hostname, stateVersion, ... }:
let
  programsDir = ./modules/home-manager/programs;
  programs = lib.forEach (builtins.attrNames (builtins.readDir programsDir)) (dirname: programsDir + /${dirname});
in
{
  imports = [
    ./hosts/${hostname}/users/${username}/preferences.nix
    ./scripts
    ./modules/home-manager/common
    ./modules/home-manager/desktop-configs
    ./modules/home-manager/stylix
  ] ++ programs;

  home = {
    inherit username;
    inherit stateVersion;
    homeDirectory = "/home/${username}";
  };
  programs.home-manager.enable = true;
  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
    };
  };
}
