{ username, hostName, pkgs, outputs, lib, stateVersion, ... }:
let
  isMinUser = builtins.substring 0 7 hostName == "server-";
  programsDir = ./modules/home-manager/programs;
  programs = lib.forEach (builtins.attrNames (builtins.readDir programsDir)) (dirname: programsDir + /${dirname});
in
{
  imports = programs
    ++ lib.optionals (isMinUser) [ ./modules/home-manager/templates/minimal.nix ]
    ++ lib.optionals (!isMinUser) [
    ./modules/home-manager/templates
    ./modules/home-manager/stylix
  ] ++ [
    ./modules/home-manager/options.nix
    ./modules/home-manager/desktop-configs
  ];

  programs.home-manager.enable = true;

  home = {
    packages = [ pkgs.home-manager ];
    inherit username stateVersion;
    homeDirectory = "/home/${username}";
  };

  # enable gh for all users
  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
  };

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config.allowUnfree = true;
  };
}
