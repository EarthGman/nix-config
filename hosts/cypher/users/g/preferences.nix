{ pkgs, outputs, lib, inputs, system, icons, ... }:
{
  # let
  #   inherit (lib) getExe;
  #   kl-script = pkgs.writeScript "knight-launcher.sh" ''
  #     cd ~/.steam/steamapps/common/Spiral\ Knights
  #     ${getExe pkgs.steam-run} ${getExe pkgs.jre} -jar ~/.steam/steam/steamapps/common/Spiral\ Knights/KnightLauncher.jar
  #   '';
  # in
  # {
  #   xdg.dataFile."applications/knight-launcher.desktop" = {
  #     enable = true;
  #     text = ''
  #       [Desktop Entry]
  #       Name=Knight Launcher
  #       Comment=poorly written 3rd party spiral knights launcher and manager
  #       Icon=${builtins.fetchurl icons.knight-launcher}
  #       Termimal=true
  #       Exec=${kl-script}
  #       Type=Application
  #       Categories=Game
  #     '';
  #   };


  programs = {
    alacritty.enable = true;
    prismlauncher.package = inputs.prismlauncher.packages.${system}.default;
    zint.enable = true;
    gparted.enable = true;
    glabels.enable = true;
    musescore.enable = true;
    gnome-clocks.enable = true;
    lutris.enable = true;
    ardour.enable = true;
    dolphin-emu.enable = true;
    cemu.enable = true;
    mcrcon.enable = true;
    # davinci-resolve.enable = true;
    obs-studio.enable = true;
    ryujinx.enable = true;
    # vinegar.enable = true;
    ygo-omega.enable = true;
  };

  # kanshi profiles
  services.kanshi = {
    enable = true;
    settings = [
      # https://gitlab.freedesktop.org/xorg/xserver/-/issues/899 It is impressive how screwed up xwayland is
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
