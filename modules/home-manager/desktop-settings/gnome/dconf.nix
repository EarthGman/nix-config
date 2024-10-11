{
  dconf.settings = {
    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,maximize,close";
    };
    # nobody likes these
    "org/gnome/desktop/interface" = {
      enable-hot-corners = false;
    };
    "org/gnome/shell" = {
      disable-user-extensions = false;
    };
    # "org/gnome/settings-daemon/plugins/media-keys" = {
    #   custom-keybindings = "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/";
    # };
    # "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
    #   command = "${pkgs.lib.getExe pkgs.kitty}";
    #   name = "Kitty";
    #   binding = "<Super>Return";
    # };
  };
}
