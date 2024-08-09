{ outputs, ... }:
{
  # extra config for home-manager. anything here will not apply to any user on any system other than this one

  stylix.image = outputs.wallpapers.survivors;
  stylix.colorScheme = "vibrant-cool";

  #firefox
  firefox.theme.name = "shyfox";
  firefox.theme.config.wallpaper = outputs.wallpapers.get-mooned;

  # gaming
  dolphin-emu.enable = true;
  ffxiv-launcher.enable = false;
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
  libreoffice.enable = false;
  obsidian.enable = false;

  #discord with vesktop
  discord.enable = true;

  # image and video
  gimp.enable = true;
  openshot.enable = false;
  davinci-resolve.enable = false;
  obs-studio.enable = false;

  # audio and music
  musescore.enable = false;
  museeks.enable = true;
  audacity.enable = true;
  clipgrab.enable = true;

  # tools
  autokey.enable = false;
  dosbox.enable = false;
  looking-glass.enable = false;
  wine.enable = true;
  gcolor.enable = true;
  flips.enable = false;
  pika-backup.enable = false;
  checkra1n.enable = false;
  solaar.enable = false;
  wireshark.enable = false;
  xclicker.enable = true;

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
}
