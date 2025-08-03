{
  pkgs,
  lib,
  config,
  ...
}:
let
  xcfg = config.services.xserver;
  weston-ini = pkgs.writeText "weston.ini" ''
    [core]
    xwayland=false
    shell=fullscreen-shell.so

    [keyboard]
    keymap_model=${builtins.toString xcfg.xkb.model}
    keymap_layout=${builtins.toString xcfg.xkb.layout}
    keymap_options=${builtins.toString xcfg.xkb.options}
    keymapvariant=

    [libinput]
    enable-tap=true
    left-handed=true

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
        compositor = lib.mkForce "weston";
        inherit compositorCommand;
      };
      themeConfig = {
        FullBlur = "false";
        PartialBlur = "false";
      };
    };
  };
}
