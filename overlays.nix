{ inputs, myLib, ... }:
{
  nixpkgs-master = final: _: {
    master = import inputs.nixpkgs-master {
      inherit (final) system;
      config.allowUnfree = true;
    };
  };

  nur = inputs.nur.overlay;

  # additional packages added to the package set
  packages = final: _prev: import ./pkgs { pkgs = final; inherit myLib; };
} 
