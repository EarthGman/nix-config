{...}:
{
  dconf.settings = {
    # dash to panel
    "org/gnome/shell" = {
      disable-user-extensions = false;

      enabled-extensions = [
        "dash-to-panel@jderose9.github.com"
      ];
    };

    # virt manager
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
    # window manager preferences
    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,maximize,close";
    };
  };

}
