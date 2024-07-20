{ pkgs, ... }:
{
  nordvpn = pkgs.callPackage ./nordvpn.nix { };
  # forces version B6 since B7-rc1 is broken for my VM
  looking-glass-client = pkgs.callPackage ./looking-glass.nix { };
  gnome-tilingShell = pkgs.callPackage ./tilingshell.nix { };
  userchrome-toggle-extended = pkgs.callPackage ./uct-extended.nix { };
  sddm-themes = import ./themes/sddm { inherit pkgs; };
  grub-themes = import ./themes/grub { inherit pkgs; };
}
