{ pkgs, mylib, ... }:
let
  inherit (pkgs) callPackage;
  inherit (mylib) mapfiles;
  makePackages = builtins.mapAttrs (name: value: callPackage (builtins.toPath value) { });
in
{
  nordvpn = callPackage ./nordvpn.nix { };
  gnome-tilingShell = callPackage ./tilingshell.nix { };
  userchrome-toggle-extended = callPackage ./uct-extended.nix { };
  sddm-themes = makePackages (mapfiles ./themes/sddm);
  grub-themes = makePackages (mapfiles ./themes/grub);
  shyfox = callPackage ./themes/firefox/shyfox.nix { };
}
