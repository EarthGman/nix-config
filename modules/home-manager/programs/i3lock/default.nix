{ lib, config, ... }:
# enabling i3 enables i3lock by default
let
  cfg = config.programs.i3lock.settings;
  inherit (lib) mkIf mkOption mkEnableOption types;
in
{
  options.programs.i3lock.settings = {
    image = mkOption {
      description = "image for i3lock";
      type = types.str;
      default = "";
    };
    color = mkOption {
      description = "background color of the lockscreen given in RGB 24 bit color";
      type = types.str;
      default = "000000"; # make screen black by default instead of the blinding white
    };
    noFork = mkEnableOption "whether to fork process after starting";
    beep = mkEnableOption "enable beeping";
    noUnlockIndicator = mkEnableOption "disable the unlock indicator";
    tiling = mkEnableOption ''
      If an image is specified (via -i) it will display the image tiled all over the screen
      (if it is a multi-monitor setup, the image is visible on all screens).
    '';
    windowsPointer = mkEnableOption "force a windows pointer on the lockscreen";
    ignoreEmptyPassword = mkEnableOption "ignores empty passwords so you dont have to wait a few seconds";
    showFailedAttempts = mkEnableOption "show failed login attempts";
    showKeyboardLayout = mkEnableOption "shows the current keyboard layout";
  };

  config = mkIf config.xsession.windowManager.i3.enable {
    xdg.configFile."i3/i3lock.sh" = {
      enable = true;
      executable = true;
      text = ''
        #!/usr/bin/env bash
        i3lock \
        ${if cfg.image != "" then "-i ${cfg.image}" else ""} \
        -c ${cfg.color} \
        ${if cfg.noFork then "-n" else ""} \
        ${if cfg.beep then "-b" else ""} \
        ${if cfg.noUnlockIndicator then "-u" else ""} \
        ${if cfg.tiling then "-t" else ""} \
        ${if cfg.windowsPointer then "-p win" else "-p default"} \
        ${if cfg.ignoreEmptyPassword then "-e" else ""} \
        ${if cfg.showFailedAttempts then "-f" else ""} \
        ${if cfg.showKeyboardLayout then "-k" else ""} \
      '';
    };
  };
}



