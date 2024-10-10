{ self, pkgs, icons, ... }:
let
  template = self + /templates/home-manager/bean.nix;
  theme = self + /modules/home-manager/desktop-configs/themes/faraway.nix;
in
{
  imports = [
    theme
    template
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

    alacritty.enable = true;
    kitty.enable = true;
  };

  # use alacritty because kitty will not work on this PC
  # mysteriously crashes every time any icon is loaded for any reason and I cannot fix it
  stylix.fonts = {
    monospace = {
      name = "MesloLGL Nerd Font";
      package = pkgs.nerdfonts.override { fonts = [ "Meslo" ]; };
    };
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
      liquidctl --match kraken set lcd screen gif ${builtins.fetchurl icons.pluto-expanded}
      liquidctl --match kraken set pump speed 70
      liquidctl --match kraken set fan speed 70
    '';
  };
}
