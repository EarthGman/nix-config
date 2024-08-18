{ outputs, ... }:
{
  # extra config for home-manager. anything here will not apply to any user on any system other than this one
  #firefox
  firefox.theme.name = "shyfox";
  firefox.theme.config.wallpaper = outputs.wallpapers.two-hallow-knights;
  stylix.image = outputs.wallpapers.siblings;
  stylix.colorScheme = "warmth";

  # gaming
  dolphin-emu.enable = false;
  ffxiv-launcher.enable = false;
  lutris.enable = true;
  prismlauncher.enable = true;

  # coding
  vscode.enable = true;
  neovim.enable = false;
  zed.enable = false;
  github-desktop.enable = false;
  lazygit.enable = false;

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
  museeks.enable = false;
  audacity.enable = false;
  clipgrab.enable = false;

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
  xclicker.enable = false;

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
