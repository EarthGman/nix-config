{ pkgs, inputs, ... }:
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
    overlays = [
      inputs.nur.overlay
      (final: _: {
        unstable = import inputs.nixpkgs-unstable {
          inherit (final) system;
          config.allowUnfree = true;
        };
      })
      (final: _prev: import ../../../pkgs { pkgs = final; })
    ];
    config = {
      allowUnfree = true;
    };
  };
}
