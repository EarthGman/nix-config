{ pkgs, config, lib, inputs, outputs, ... }:

{
  nix = {
    package = pkgs.nixFlakes;

    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
      substituters = [
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
    gc = {
      automatic = true;
    };
    nixPath = [ "nixpkgs=${inputs.nixpkgs.outPath}" ];
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;
  };
  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
      allowUnsupportedSystem = true;
      permittedInsecurePackages = [
        "electron-25.9.0"
        "electron-19.1.9"
      ];
    };
  };
}
