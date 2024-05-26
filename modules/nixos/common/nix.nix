{ pkgs, inputs, ... }:
{
  nixpkgs = {
    overlays = [
      inputs.nur.overlay
      (final: _: {
        unstable = import inputs.nixpkgs-unstable {
          inherit (final) system;
          config.allowUnfree = true;
        };
      })
      #(final: _prev: import ../../pkgs { pkgs = final; })
    ];
    config = {
      allowUnfree = true;
    };
  };
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
