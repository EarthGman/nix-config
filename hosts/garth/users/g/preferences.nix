{ outputs, ... }:
{
  stylix.image = outputs.wallpapers.fiery-dragon;
  stylix.colorScheme = "inferno";

  firefox.theme.name = "shyfox";

  # gaming
  dolphin-emu.enable = true;
  lutris.enable = true;
  prismlauncher.enable = true;

  # coding
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
  openshot.enable = true;
  obs-studio.enable = true;
  moonlight.enable = true;

  # audio and music
  musescore.enable = true;
  museeks.enable = true;
  audacity.enable = true;
  clipgrab.enable = true;

  # tools
  autokey.enable = true;
  dosbox.enable = true;
  looking-glass.enable = true;
  wine.enable = true;
  gcolor.enable = true;
  flips.enable = true;
  pika-backup.enable = true;
  yazi.enable = true;

  # tops
  powertop.enable = true;
  radeontop.enable = true;

  # info
  neofetch.enable = true;

  # clients
  filezilla.enable = true;
  remmina.enable = true;
  openconnect.enable = true;
}
