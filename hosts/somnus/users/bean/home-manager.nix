{
  pkgs,
  ...
}:
let
  liquidctl-profile = pkgs.writeScriptBin "liquidctl-profile" ''
    liquidctl --match kraken set external color fixed 2f18d6
    liquidctl --match kraken set lcd screen gif ${pkgs.images.pluto-expanded}
    liquidctl --match kraken set pump speed 70
    liquidctl --match kraken set fan speed 70
  '';
in
{
  home.packages = [ liquidctl-profile ];
  meta.profiles.desktopTheme = "cozy-undertale";

  programs = {
    dolphin-emu.enable = true;
    cemu.enable = true;
    prismlauncher.enable = true;
    discord.enable = true;
    ffxiv-launcher.enable = true;
    lutris.enable = true;
    bottles.enable = true;

    cmatrix.enable = true;
    cbonsai.enable = true;
    pipes.enable = true;
    ryubing.enable = true;
    sl.enable = true;
  };
}
