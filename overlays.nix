{ inputs, ... }:
{
  nur = inputs.nur.overlays.default;

  my-neovims = inputs.vim-config.overlays.default;

  my-packages = inputs.nix-library.overlays.default;

  # cuts out roughly 600Mb of bloat
  disable-mbrola-voices = final: prev: {
    espeak = prev.espeak.override {
      mbrolaSupport = false;
    };
  };
} 
