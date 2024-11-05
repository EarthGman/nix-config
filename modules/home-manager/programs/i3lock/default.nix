{ pkgs, lib, config, ... }:
# enabling i3 enables i3lock by default
let
  inherit (lib) mkIf mkOption mkEnableOption types;
  i3lock = import ./script.nix { inherit pkgs lib config; };
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
    home.packages = [ i3lock ];
  };
}



