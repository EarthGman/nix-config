{ inputs, config, ... }:
{
  programs = {
    moonlight.enable = true;
    audacity.enable = true;
    cutentr.enable = true;
    davinci-resolve.enable = true;
    bustle.enable = true;
    bottles.enable = true;
    filezilla.enable = true;
    gimp.enable = true;
    prismlauncher = {
      enable = true;
      # newest version of prism
      package = inputs.prismlauncher.packages.${config.meta.system}.default;
    };
    gcolor.enable = true;
    musescore.enable = true;
    lutris.enable = true;
    ledger-live-desktop.enable = true;
    libreoffice.enable = true;
    ardour.enable = true;
    dolphin-emu.enable = true;
    cemu.enable = true;
    mcrcon.enable = true;
    obs-studio.enable = true;
    puddletag.enable = true;
    ryubing.enable = true;
    # no compatible mouse :(
    piper.enable = false;
    blender.enable = true;
    ani-cli.enable = true;
    video-trimmer.enable = true;
  };
}
