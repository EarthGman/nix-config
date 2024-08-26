{ outputs, ... }:
{
  # extra config for home-manager. anything here will not apply to any user on any system other than this one
  stylix.image = outputs.wallpapers.kaori;
  stylix.colorScheme = "april";

  firefox.theme.name = "shyfox";
  firefox.theme.config.wallpaper = outputs.wallpapers.april-night;

  # gaming
  dolphin-emu.enable = true;
  lutris.enable = true;
  prismlauncher.enable = true;
  ygo-omega.enable = true;

  # coding
  neovim.enable = true;
  github-desktop.enable = true;
  lazygit.enable = true;

  # productivity
  thunderbird.enable = true;
  libreoffice.enable = true;
  obsidian.enable = true;

  #discord with vesktop
  discord.enable = true;

  # image and video
  gimp.enable = true;
  davinci-resolve.enable = true;
  obs-studio.enable = true;
  mupdf.enable = true;
  switcheroo.enable = true;

  # audio and music
  musescore.enable = true;
  museeks.enable = true;
  audacity.enable = true;
  clipgrab.enable = true;

  # tools
  autokey.enable = true;
  dosbox.enable = true;
  looking-glass.enable = true;
  looking-glass.version = "B6";
  wine.enable = true;
  gcolor.enable = true;
  flips.enable = true;
  pika-backup.enable = true;
  wireshark.enable = true;
  xclicker.enable = true;
  yazi.enable = true;

  # tops
  powertop.enable = true;
  radeontop.enable = true;

  # info
  neofetch.enable = true;

  # clients
  filezilla.enable = true;
  remmina.enable = true;
}
