{ username, lib, ... }:
{
  dconf.settings = {
    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,maximize,close";
    };
    "org/gnome/desktop/interface" = {
      enable-hot-corners = false;
    };
    "org/gnome/desktop/peripherals/mouse" = lib.mkIf (username == "g") {
      left-handed = true;
    };
  };
}
