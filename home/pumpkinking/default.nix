{ hostname, ... }:
let
  extraHM = ../../hosts/${hostname}/users/pumpkinking/home-manager.nix;
in
{
  imports = if builtins.pathExists extraHM then [ extraHM ] else [ ];

  meta.profiles.firefox = "shyfox";

  programs.git = {
    userName = "PumpkinKing432";
    userEmail = "trombonekidd17@gmail.com";
  };
}
