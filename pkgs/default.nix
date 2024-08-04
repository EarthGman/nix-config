{ pkgs, mylib, ... }:
let
  inherit (pkgs) callPackage;
  inherit (mylib) mapfiles;
  makePackages = builtins.mapAttrs (name: value: callPackage (builtins.toPath value) { });
in
{
  nordvpn = callPackage ./nordvpn.nix { };
  # forces version B6 since B7-rc1 is broken for my VM
  looking-glass-client = callPackage ./looking-glass.nix { };
  gnome-tilingShell = callPackage ./tilingshell.nix { };
  userchrome-toggle-extended = callPackage ./uct-extended.nix { };
  sddm-themes = makePackages (mapfiles ./themes/sddm);
  grub-themes = makePackages (mapfiles ./themes/grub);
}
