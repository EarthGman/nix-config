{ self, wallpapers, ... }:
let
  template = self + /templates/home-manager/bean.nix;
  inherit (builtins) fetchurl;
in
{
  imports = [ template ];

  stylix.image = fetchurl wallpapers.the-gang-headspace;
  stylix.colorScheme = "headspace";

  programs = {
    firefox.theme.name = "shyfox";
    firefox.theme.config.wallpaper = fetchurl wallpapers.headspace-dark;

    prismlauncher.enable = true;
    discord.enable = true;
    ffxiv-launcher.enable = true;
    lutris.enable = true;
    bottles.enable = true;
    davinci-resolve.enable = true;

    cmatrix.enable = true;
    cbonsai.enable = true;
    pipes.enable = true;
  };

  wayland.windowManager.hyprland.mainMod = "SUPER";

  programs.zsh.shellAliases = {
    "lctl" = "sudo -E liquidctl-profile";
  };
  home.file."bin/liquidctl-profile" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      liquidctl --match kraken set external color fixed 2f18d6
      liquidctl --match kraken set lcd screen gif /home/bean/Pictures/pluto-expanded.gif
      liquidctl --match kraken set pump speed 70
      liquidctl --match kraken set fan speed 70
    '';
  };
}
