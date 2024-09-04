{ inputs, ... }:
{
  nixpkgs-master = final: _: {
    master = import inputs.nixpkgs-master {
      inherit (final) system;
      config.allowUnfree = true;
    };
  };
} 
