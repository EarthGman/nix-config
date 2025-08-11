{ config, ... }:
let
  ln = config.lib.file.mkOutOfStoreSymlink;
in
{
  meta.profiles.desktopTheme = "omori-faraway";

  xdg = {
    configFile = {
      "Ryujinx".source = ln "/home/bean/games/ryujinx";
      "Cemu".source = ln "/home/bean/games/cemu";
    };
    dataFile = {
      "dolphin-emu".source = ln "/home/bean/games/dolphin-emu";
      "PrismLauncher".source = ln "/home/bean/games/prismlauncher";
    };
  };
}
