{ outputs, ... }:
{
  # stylix
  stylix.image = outputs.wallpapers.siblings;
  stylix.colorScheme = "vibrant-cool";

  # gaming
  dolphin-emu.enable = false;
  ffxiv-launcher.enable = false;
  lutris.enable = false;
  prismlauncher.enable = false;

  # coding
  vscode.enable = true;
  neovim.enable = false;
  zed.enable = false;
  github-desktop.enable = false;
  lazygit.enable = false;

  # productivity
  thunderbird.enable = true;
  freeoffice.enable = false;
  libreoffice.enable = true;
  obsidian.enable = true;

  #discord with vesktop
  discord.enable = false;

  # image and video
  gimp.enable = true;
  openshot.enable = false;
  davinci-resolve.enable = false;
  obs-studio.enable = true;
  zoom.enable = true;

  # audio and music
  musescore.enable = false;
  museeks.enable = false;
  audacity.enable = false;
  clipgrab.enable = false;

  # tools
  dosbox.enable = false;
  looking-glass.enable = false;
  wine.enable = true;
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

  # info
  neofetch.enable = true;

  # clients
  filezilla.enable = false;
  remmina.enable = false;
}
