{ inputs, ... }:
{
  nur = inputs.nur.overlays.default;

  # temporary until freelens makes it into nixpkgs
  freelens-stuff = final: prev: {
    inherit (inputs.matthewpi.packages.${prev.system}) freelens freelens-k8s-proxy;
  };

  my-neovims = inputs.vim-config.overlays.default;

  my-packages = inputs.nix-library.overlays.default;

  # cuts out roughly 600Mb of bloat
  disable-mbrola-voices = final: prev: {
    espeak = prev.espeak.override {
      mbrolaSupport = false;
    };
  };
}
