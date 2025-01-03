{ pkgs, lib, config, hostName, ... }:
let
  cfg = config.programs.waybar;
in
{
  options.programs.waybar = {
    theme = lib.mkOption {
      description = "theme for waybar";
      type = lib.types.str;
      default = "default";
    };
    topBar.settings = lib.mkOption {
      description = "configuration for the top waybar";
      type = lib.types.anything;
      default = { };
    };
    bottomBar.settings = lib.mkOption {
      description = "configuration for the bottom waybar";
      type = lib.types.anything;
      default = { };
    };
  };
  config = {
    programs.waybar = {
      systemd.enable = true;
      bottomBar.settings = import ./bottom-bar.nix { inherit pkgs config lib hostName; };
      settings = [
        cfg.topBar.settings
        cfg.bottomBar.settings
      ];
      style = builtins.readFile ./themes/${config.programs.waybar.theme}/style.css;
    };
    home.packages = lib.mkIf config.programs.waybar.enable (with pkgs; [
      nerd-fonts.meslo-lg
    ]);

    systemd.user.services.waybar = {
      Unit.After = [ "graphical-session.target" ];
      Service.Slice = [ "app-graphical.slice" ];
    };

    # settings menu
    xdg.configFile = {
      "waybar/settings-menu.xml" = {
        enable = cfg.enable;
        text = ''
            <?xml version="1.0" encoding="UTF-8"?>
            <interface>
              <object class="GtkMenu" id="menu">
            	<child>
                <object class="GtkMenuItem" id="lockscreen">
            			<property name="label"> Lock Screen</property>
                </object>
            	</child>
              <child>
              <object class="GtkMenuItem" id="reboot">
                <property name="label"> Reboot</property>
              </object>
              </child>
              <child>
                <object class="GtkSeparatorMenuItem" id="delimiter1"/>
              </child>
              <child>
                <object class="GtkMenuItem" id="shutdown">
                  <property name="label"> Shutdown</property>
                </object>
              </child>
            </object>
          </interface>
        '';
      };
    };
  };
}
