{ inputs, ... }:
{
  nixpkgs-master = final: _: {
    master = import inputs.nixpkgs-master {
      inherit (final) system;
      config.allowUnfree = true;
    };
  };

  nixpkgs-stable = final: _: {
    stable = import inputs.nixpkgs-stable {
      inherit (final) system;
      config.allowUnfree = true;
    };
  };

  nur = inputs.nur.overlays.default;

  # additional packages added to the package set
  packages = final: _prev: import ./pkgs { pkgs = final; inherit inputs; };

  # cuts out roughly 600Mb of bloat
  disable-mbrola-voices = final: prev: {
    espeak = prev.espeak.override {
      mbrolaSupport = false;
    };
  };

} 
