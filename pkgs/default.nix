{ pkgs, ... }:
let
  grub-themes = import ./themes/grub { inherit pkgs; };
  sddm-themes = import ./themes/sddm { inherit pkgs; };
in
{
  nordvpn = pkgs.callPackage ./nordvpn.nix { };
  # forces version B6 since B7-rc1 is broken for my VM
  looking-glass-client = pkgs.callPackage ./looking-glass.nix { };
  gnome-tilingShell = pkgs.callPackage ./tilingshell.nix { };
  userchrome-toggle-extended = pkgs.callPackage ./uct-extended.nix { };

  #grub-themes
  nixos-grub-theme = grub-themes.nixos;

  #sddm themes
  afterglow = sddm-themes.afterglow;
  april = sddm-themes.april;
  bluish-sddm = sddm-themes.bluish-sddm;
  oneshot = sddm-themes.oneshot;
  hallow-knight = sddm-themes.hallow-knight;
  sugar-dark = sddm-themes.sugar-dark;
  utterly-sweet = sddm-themes.utterly-sweet;
  inferno = sddm-themes.inferno;
}
