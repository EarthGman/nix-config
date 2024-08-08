{ outputs, ... }:
{
  firefox.theme.name = "shyfox";
  firefox.theme.config.wallpaper = outputs.wallpapers.blackspace;
  # gaming
  dolphin-emu.enable = false;
  ffxiv-launcher.enable = false;
  lutris.enable = false;
  prismlauncher.enable = false;

  # coding
  vscode.enable = true;
  neovim.enable = true;
  zed.enable = true;
  github-desktop.enable = true;
  lazygit.enable = true;

  # productivity
  thunderbird.enable = false;
  freeoffice.enable = false;
  libreoffice.enable = false;
  obsidian.enable = false;

  #discord with vesktop
  discord.enable = false;
  betterdiscord.enable = false;

  # image and video
  gimp.enable = true;
  openshot.enable = false;
  obs-studio.enable = false;

  # audio and music
  musescore.enable = false;
  museeks.enable = false;
  audacity.enable = false;
  clipgrab.enable = true;

  # tools
  dosbox.enable = false;
  looking-glass.enable = false;
  wine.enable = false;
  gcolor.enable = true;
  flips.enable = false;
  pika-backup.enable = false;
  checkra1n.enable = false;
  solaar.enable = false;
  yazi.enable = true;

  # tops
  nvtop.enable = false;
  powertop.enable = true;
  radeontop.enable = false;
  htop.enable = true;

  # info
  neofetch.enable = true;

  # clients
  filezilla.enable = false;
  remmina.enable = false;
}
