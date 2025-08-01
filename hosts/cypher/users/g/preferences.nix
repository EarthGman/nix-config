{
  inputs,
  config,
  system,
  ...
}:
let
  ln = config.lib.file.mkOutOfStoreSymlink;
in
{
  programs = {
    ygo-omega.enable = true;
  };

  xdg.dataFile = {
    "PrismLauncher".source = ln "/home/g/games/PrismLauncher";
    "Terraria".source = ln "/home/g/games/SteamLibrary/game-saves/Terraria";
    "Cemu".source = ln "/home/g/games/Cemu";
    "dolphin-emu".source = ln "/home/g/games/dolphin-emu";
  };

  xdg.configFile = {
    "Ryujinx".source = ln "/home/g/games/Ryujinx";
    "StardewValley".source = ln "/home/g/games/SteamLibrary/game-saves/StardewValley";
    "unity3d/Pugstorm/Core\ Keeper".source = ln "/home/g/games/SteamLibrary/game-saves/Core\ Keeper";
  };

  # kanshi profiles
  services.kanshi = {
    enable = true;
    settings = [
      # https://gitlab.freedesktop.org/xorg/xserver/-/issues/899
      {
        profile.name = "home";
        profile.outputs = [
          {
            criteria = "LG Electronics LG HDR 4K 0x0007B5B9";
            position = "1920,0";
            mode = "2560x1440@59.951Hz";
          }
          {
            criteria = "Sceptre Tech Inc Sceptre F24 0x01010101";
            position = "0,0";
            mode = "1920x1080@100Hz";
          }
        ];
      }
      {
        profile.name = "school";
        profile.outputs = [
          {
            criteria = "Philips Consumer Electronics Company PHL BDM4350 0x000005E8";
            position = "1920,0";
            mode = "2560x1440@59.95Hz";
          }
          {
            criteria = "Sceptre Tech Inc E24 0x01010101";
            position = "0,0";
            mode = "1920x1080@74.97Hz";
          }
        ];
      }
    ];
  };

  # monitors for xorg
  xsession.profileExtra = ''
    xrandr --output DisplayPort-2 --auto --right-of HDMI-A-0 \
           --output DisplayPort-2 --mode 2560x1440 \
           --output HDMI-A-0 --mode 1920x1080 --rate 74.97 \
  '';
}
