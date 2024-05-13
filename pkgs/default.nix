{ pkgs ? import <nixpks> { } }: rec {
  # vinegar = pkgs.callPackage ./vinegar.nix {
  #   wine = pkgs.inputs.nix-gaming.wine-ge;
  # };
  nordvpn = pkgs.callPackage ./nordvpn.nix { };
  looking-glass-client = pkgs.callPackage ./looking-glass.nix { };
}
