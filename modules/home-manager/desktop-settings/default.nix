{ pkgs, lib, desktop, ... }:
let
  inherit (lib) optionals mkDefault mkIf;
  inherit (builtins) elem;
  desktops = if (desktop != null) then lib.stringToList desktop "," else [ ];
  i3 = elem "i3" desktops;
  gnome = elem "gnome" desktops;
  hyprland = elem "hyprland" desktops;
in
{
  imports = optionals i3 [ ./i3 ]
    ++ optionals gnome [ ./gnome ]
    ++ optionals hyprland [ ./hyprland ];
  config = mkIf (desktop != null) {
    # icons for gtk apps
    gtk = {
      enable = mkDefault true;
      iconTheme = {
        name = mkDefault "Adwaita";
        package = mkDefault pkgs.adwaita-icon-theme;
      };
    };
  };
}
