{
  # extra config for home-manager. anything here will not apply to any user on any system other than this one
  brave.enable = false;

  # gaming
  dolphin-emu.enable = true;
  ffxiv-launcher.enable = false;
  lutris.enable = true;
  prismlauncher.enable = true;

  # coding
  vscode.enable = true;
  vim.enable = false;
  zed.enable = false;
  github-desktop.enable = true;
  lazygit.enable = true;

  # productivity
  thunderbird.enable = true;
  freeoffice.enable = false;
  libreoffice.enable = true;
  obsidian.enable = true;

  #discord with vesktop
  discord.enable = true;
  betterdiscord.enable = false;

  # image and video
  gimp.enable = true;
  openshot.enable = true;
  davinci-resolve.enable = true;
  obs-studio.enable = true;

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
  checkra1n.enable = false;
  solaar.enable = false;
  wireshark.enable = true;
  xclicker.enable = true;

  # tops
  nvtop.enable = false;
  powertop.enable = true;
  radeontop.enable = true;
  htop.enable = true;

  # info
  neofetch.enable = true;

  # clients
  filezilla.enable = true;
  remmina.enable = false;

  home.file = {
    "bin/ygo-omega" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash
        steam-run ~/games/ygo-omega/OmegaUpdater
      '';
    };
    ".local/share/applications/ygo-omega.desktop" = {
      text = ''
        [Desktop Entry]
        Name=YGO Omega
        Comment=Yugioh Simulator
        Icon=/home/g/games/ygo-omega/YGO Omega_Data/Resources/UnityPlayer.png
        Exec=steam-run /home/g/games/ygo-omega/OmegaUpdater
        Terminal=false
        Type=Application
        Categories=Game
      '';
    };
  };
}
