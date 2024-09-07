{ pkgs, myLib, lib, desktop, ... }:
let
  inherit (lib) optionals mkDefault mkIf mkForce;
  inherit (builtins) elem;
  desktops = if (desktop != null) then myLib.splitToList desktop else [ ];
  i3 = elem "i3" desktops;
  gnome = elem "gnome" desktops;
in
{
  imports = optionals i3 [ ./i3 ]
    ++ optionals gnome [ ./gnome ];
  config = mkIf (desktop != null) {
    gtk = {
      enable = mkDefault true;
      iconTheme = mkDefault {
        name = mkDefault "Adwaita";
        package = mkDefault pkgs.adwaita-icon-theme;
      };
    };
    qt = {
      enable = mkDefault true;
      # platformTheme.name = mkDefault "adwaita-dark";
      style.name = mkDefault "Fusion";
      style.package = mkForce pkgs.adwaita-qt;
    };
  };
}
