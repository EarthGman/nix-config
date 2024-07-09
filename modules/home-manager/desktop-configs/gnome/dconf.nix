{ pkgs, username, lib, ... }:
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
    # "org/gnome/shell" = {
    #   disable-user-extensions = false;
    #   enabled-extensions = [
    #     "tilingshell@ferrarodomenico.com"
    #   ];
    # };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      command = "${pkgs.lib.getExe pkgs.kitty}";
      name = "Kitty";
      binding = "<Super>Return";
    };
  };
}
