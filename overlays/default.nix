{ inputs, ... }:
{
  additions = final: _prev: import ../pkgs { pkgs = final; };

  nur = inputs.nur.overlay;
  nixpkgs-unstable = final: _: {
    unstable = import inputs.nixpkgs-unstable {
      inherit (final) system;
      config.allowUnfree = true;
    };
  };
}
