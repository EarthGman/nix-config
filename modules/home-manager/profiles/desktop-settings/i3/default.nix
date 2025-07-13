{ lib, config, ... }:
let
  inherit (lib)
    mkDefault
    optionals
    mkEnableOption
    mkIf
    mkMerge
    ;
  enabled = {
    enable = mkDefault true;
  };
  cfg = config.profiles.i3.default;
in
{
  options.profiles.i3.default.enable = mkEnableOption "default i3 profile";
  config = mkIf cfg.enable (mkMerge [
    {
      stylix.targets.i3.enable = true;

      programs = {
        i3lock.settings = {
          ignoreEmptyPassword = mkDefault true;
        };
      };

      xsession = {
        windowManager.i3 = {
          config.startup =
            [
              {
                command = "systemctl --user restart polybar";
                always = true;
                notification = false;
              }
              {
                command = "i3-msg workspace 1";
                always = false;
                notification = false;
              }
            ]
            ++ optionals (config.services.fehbg.enable) [
              {
                command = "systemctl --user restart fehbg";
                always = true;
                notification = false;
              }

            ]
            ++ optionals (config.services.omori-calendar-project.enable) [
              {
                command = "systemctl --user restart omori-calendar-project";
                always = true;
                notification = false;
              }
            ];
        };
      };
    }
    (mkIf config.xsession.windowManager.i3.enable {
      services = {
        fehbg = enabled; # wallpapers
        polybar = enabled;
        picom = enabled; # x compositor that stops screen tearing
      };
    })
  ]);
}
