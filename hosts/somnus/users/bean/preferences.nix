{ outputs, ... }:
{
  stylix.image = outputs.wallpapers.the-gang-headspace;
  stylix.colorScheme = "headspace";

  #firefox
  firefox.theme.name = "shyfox";
  firefox.theme.config.wallpaper = outputs.wallpapers.headspace-dark;

  # gaming
  dolphin-emu.enable = true;
  ffxiv-launcher.enable = true;
  lutris.enable = true;
  prismlauncher.enable = true;

  # coding
  vscode.enable = true;
  neovim.enable = false;
  zed.enable = false;
  github-desktop.enable = true;
  lazygit.enable = true;

  # productivity
  thunderbird.enable = false;
  freeoffice.enable = false;
  libreoffice.enable = true;
  obsidian.enable = true;

  #discord with vesktop
  discord.enable = true;

  # image and video
  gimp.enable = true;
  openshot.enable = true;
  obs-studio.enable = true;

  # audio and music
  musescore.enable = true;
  museeks.enable = true;
  audacity.enable = true;
  clipgrab.enable = true;

  # tools
  dosbox.enable = false;
  looking-glass.enable = false;
  wine.enable = true;
  gcolor.enable = true;
  flips.enable = false;
  pika-backup.enable = true;
  checkra1n.enable = false;
  solaar.enable = false;

  # yazi
  yazi.enable = true;

  # tops
  nvtop.enable = false;
  powertop.enable = true;
  radeontop.enable = true;

  # info
  neofetch.enable = true;

  # clients
  filezilla.enable = false;
  remmina.enable = false;

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
