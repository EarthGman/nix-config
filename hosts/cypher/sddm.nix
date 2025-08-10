{
  pkgs,
  lib,
  config,
  ...
}:
let
  xcfg = config.services.xserver;
  # only display sddm on primary display
  weston-ini = pkgs.writeText "weston.ini" ''
    [keyboard]
    keymap_model=${builtins.toString xcfg.xkb.model}
    keymap_layout=${builtins.toString xcfg.xkb.layout}
    keymap_options=${builtins.toString xcfg.xkb.options}

    [output]
    name=DisplayPort-2
    mode=2560x1440@60

    [output]
    name=HDMI-A-0
    mode=off
  '';

  compositorCommand = lib.concatStringsSep " " [
    "${lib.getExe pkgs.weston}"
    "--shell=kiosk"
    "-c ${weston-ini}"
  ];
in
{
  services.displayManager = {
    sddm = {
      wayland = {
        inherit compositorCommand;
      };
    };
  };
}
