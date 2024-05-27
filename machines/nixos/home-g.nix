{ config, inputs, username, stateVersion, ... }:
{
  # browsers
  firefox.enable = true;

  # gaming
  dolphin-emu.enable = true;
  ffxiv-launcher.enable = false;
  lutris.enable = true;
  prismlauncher.enable = true;
  steam.enable = true;

  # # common
  neofetch.enable = true;
  gpg.enable = true;
  looking-glass.enable = true;
  wine.enable = true;
  github-desktop.enable = true;
  lazygit.enable = true;
  gimp.enable = true;
  libreoffice.enable = true;
  obsidian.enable = true;
  discord.enable = false;
  betterdiscord.enable = false;
  remmina.enable = false;
  gcolor.enable = true;
  clipgrab.enable = true;
  openshot.enable = true;
  obs-studio.enable = true;
  audacity.enable = true;
  museeks.enable = true;
  musescore.enable = true;
  flips.enable = true;
  filezilla.enable = true;
  pika-backup.enable = true;
  radeontop.enable = false;
  nvtop.enable = false;
  powertop.enable = true;
  htop.enable = true;
  checkra1n.enable = false;



  home = {
    inherit username;
    inherit stateVersion;
    homeDirectory = "/home/${username}";
    sessionVariables = {
      EDITOR = "code --wait";
    };
  };
  programs.home-manager.enable = true;

  imports = [
    ../../modules/home-manager/shells
    ../../modules/home-manager/terminals
    ../../modules/home-manager/editors
    ../../modules/home-manager/desktop-configs
    ../../modules/home-manager/browsers
    ../../modules/home-manager/common
    ../../modules/home-manager/gaming
  ];

  # allows home-manager to install unfree packages from nur
  nixpkgs = {
    overlays = [
      inputs.nur.overlay
      # (final: _: {
      #   unstable = import inputs.nixpkgs-unstable {
      #     inherit (final) system;
      #     config.allowUnfree = true;
      #   };
      # })
    ];
    config = {
      allowUnfree = true;
    };
  };
}
