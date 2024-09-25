{ pkgs, lib, config, hostName, ... }:
{
  options.programs.waybar = {
    theme = lib.mkOption {
      description = "theme for waybar";
      type = lib.types.str;
      default = "default";
    };
  };
  config = {
    programs.waybar = {
      settings = import ./settings.nix { inherit pkgs lib config hostName; };
      style = builtins.readFile ./themes/${config.programs.waybar.theme}/style.css;
    };
    home.packages = lib.mkIf config.programs.waybar.enable (with pkgs; [
      (nerdfonts.override { fonts = [ "Meslo" ]; })
    ]);
    # settings menu
    xdg.configFile = {
      "waybar/settings-menu.xml".text = ''
                <?xml version="1.0" encoding="UTF-8"?>
          <interface>
            <object class="GtkMenu" id="menu">
            <child>
              <object class="GtkMenuItem" id="wallpaper-switcher">
          			<property name="label">󰸉 Wallpapers</property>
              </object>
          	</child>
            <child>
              <object class="GtkMenuItem" id="theme-switcher">
          			<property name="label"> Themes</property>
              </object>
          	</child>
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
}
