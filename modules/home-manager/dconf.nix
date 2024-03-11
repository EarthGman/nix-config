{ lib, ... }:

# declaritive dconf settings, currently adds minimize and maximize buttons
with lib.hm.gvariant;
{
  dconf.settings = {
    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,maximize,close";
    };
  };
}
