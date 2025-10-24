{ inputs, ... }:
{
  custom-neovims = inputs.vim-config.overlays.default;
  gman-packages = inputs.nix-library.overlays.default;
  images = inputs.nix-library.overlays.images;

  swww = inputs.swww.overlays.default;

  disable-mbrola-voices = final: prev: {
    espeak = prev.espeak.override {
      mbrolaSupport = false;
    };
  };
}
