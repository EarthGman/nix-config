{ pkgs, inputs, outputs, ... }:
{
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };
    gc = {
      automatic = true;
      options = "--delete-older-than 10d";
    };
  };
  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
    };
  };
}
