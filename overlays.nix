{ inputs, ... }:
{
  custom-neovims = inputs.vim-config.overlays.default;
  gman-packages = inputs.nix-library.overlays.default;
  nur = inputs.nur.overlays.default;
  # TODO Asset repo migration
  gman-assets = inputs.assets.overlays.default;

  disable-mbrola-voices = final: prev: {
    espeak = prev.espeak.override {
      mbrolaSupport = false;
    };
  };
}
