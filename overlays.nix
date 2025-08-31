{ inputs, ... }:
{
  custom-neovims = inputs.vim-config.overlays.default;
  gman-packages = inputs.nix-library.overlays.default;
  nur = inputs.nur.overlays.default;
  images = inputs.nix-library.overlays.images;

  disable-mbrola-voices = final: prev: {
    espeak = prev.espeak.override {
      mbrolaSupport = false;
    };
  };
}
