{ inputs, ... }:
{
  custom-neovims = inputs.vim-config.overlays.default;

  packages =
    final: prev:
    import ./packages {
      inherit inputs;
      pkgs = final;
    };

  awww = inputs.awww.overlays.default;
  niri = inputs.niri.overlays.default;

  quickshell = inputs.quickshell.overlays.default;

  disable-mbrola-voices = final: prev: {
    espeak = prev.espeak.override {
      mbrolaSupport = false;
    };
  };
}
