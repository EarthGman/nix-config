{ config, ... }:
let
  mkOutOfStoreSymlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  custom.profiles.desktopTheme = "faraway";

  profiles = {
    desktopThemes = {
      headspace.withOmoriFont = true;
      faraway.withOmoriFont = true;
    };
  };

  programs = {
    dolphin-emu.enable = true;
    cemu.enable = true;
    ryujinx.enable = true;
    discord.enable = true;
    ffxiv-launcher.enable = true;
    lutris.enable = true;
    bottles.enable = true;

    cmatrix.enable = true;
    cbonsai.enable = true;
    pipes.enable = true;
    sl.enable = true;
  };

  xdg = {
    configFile = {
      "Ryujinx".source = mkOutOfStoreSymlink "/home/bean/games/ryujinx";
      "Cemu".source = mkOutOfStoreSymlink "/home/bean/games/cemu";
    };
    dataFile = {
      "dolphin-emu".source = mkOutOfStoreSymlink "/home/bean/games/dolphin-emu";
      "PrismLauncher".source = mkOutOfStoreSymlink "/home/bean/games/prismlauncher";
    };
  };
}
