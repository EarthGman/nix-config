{ self, icons, ... }:
let
  theme = self + /profiles/home-manager/desktop-themes/faraway.nix;
in
{
  imports = [
    theme
  ];

  programs = {
    prismlauncher.enable = true;
    discord.enable = true;
    ffxiv-launcher.enable = true;
    lutris.enable = true;
    bottles.enable = true;
    davinci-resolve.enable = true;

    cmatrix.enable = true;
    cbonsai.enable = true;
    pipes.enable = true;
    sl.enable = true;
  };

  programs.zsh.shellAliases = {
    "lctl" = "sudo -E liquidctl-profile";
  };
  home.file."bin/liquidctl-profile" = {
    executable = true;
    text = '' 
      #!/usr/bin/env bash
      liquidctl --match kraken set external color fixed 2f18d6
      liquidctl --match kraken set lcd screen gif ${builtins.fetchurl icons.pluto-expanded}
      liquidctl --match kraken set pump speed 70
      liquidctl --match kraken set fan speed 70
    '';
  };
}
