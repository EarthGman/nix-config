{ desktop, lib, pkgs, ... }:
let
  desktops = builtins.filter builtins.isString (builtins.split "," desktop);
  gnome = builtins.elem "gnome" desktops;
  hyprland = builtins.elem "hyprland" desktops;
in
{
  imports =
    (lib.optionals gnome [ ./gnome ]) ++
    (lib.optionals hyprland [ ./hyprland ]);

  gtk = {
    enable = true;
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
      gtk-button-images = false;
    };
  };

  qt = {
    enable = true;
  };

  xdg = {
    portal = {
      config = {
        common.default = "*";
      };
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal
        xdg-desktop-portal-gtk
      ];
    };
  };
}
