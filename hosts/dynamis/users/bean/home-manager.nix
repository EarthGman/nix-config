{ config, ... }:
let
  ln = config.lib.file.mkOutOfStoreSymlink;
in
{
  meta.profiles.desktopTheme = "omori-faraway";
  gman.profiles.desktopThemes.omori-faraway.config.withOmoriFont = true;

  xdg = {
    configFile = {
      "Ryubing".source = ln "/home/bean/games/ryujinx";
      "Cemu".source = ln "/home/bean/games/cemu";
    };
    dataFile = {
      "dolphin-emu".source = ln "/home/bean/games/dolphin-emu";
      "PrismLauncher".source = ln "/home/bean/games/prismlauncher";
    };
  };
}
