{ outputs, pkgs, lib, config, ... }:
let
  theme = outputs.homeProfiles.desktopThemes.celeste;
in
{
  imports = [
    theme
  ];

  custom.editor = "codium";

  programs = {
    r2modman.enable = true;
    bottles.enable = true;
    lutris.enable = true;
    prismlauncher.enable = true;
    discord.enable = true;
    sl.enable = true;
    cbonsai.enable = true;
    cmatrix.enable = true;
    pipes.enable = true;
    museeks.enable = true;
    obs-studio.enable = true;
    totem.enable = true;
  };
  # no printscreen, use mainMod + f1 instead
  wayland.windowManager.hyprland.extraConfig = ''
    bind=${config.wayland.windowManager.hyprland.mainMod}, F1, exec, ${lib.getExe pkgs.grim} -g \"$(${lib.getExe pkgs.slurp})\" - | ${pkgs.wl-clipboard}/bin/wl-copy && ${pkgs.wl-clipboard}/bin/wl-paste > ${config.home.homeDirectory}/Pictures/Screenshots/Screenshot-$(date +%F_%T).png
  '';
}
