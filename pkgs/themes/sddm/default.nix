{ pkgs, ... }:
{
  afterglow = pkgs.callPackage ./afterglow { };
  april = pkgs.callPackage ./april { };
  bluish-sddm = pkgs.callPackage ./bluish-sddm { };
  oneshot = pkgs.callPackage ./oneshot { };
  hallow-knight = pkgs.callPackage ./hallow-knight { };
  sugar-dark = pkgs.callPackage ./sugar-dark { };
  utterly-sweet = pkgs.callPackage ./utterly-sweet { };
  inferno = pkgs.callPackage ./inferno { };
  eucalpytus-drop = pkgs.callPackage ./eucalpytus-drop { };
  reverie = pkgs.callPackage ./reverie { };
}
