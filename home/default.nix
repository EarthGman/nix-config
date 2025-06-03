{ lib, ... }:
let
  inherit (lib) mkHome;
in
{
  "g@tater" = mkHome {
    username = "g";
    hostName = "tater";
    desktop = "hyprland";
    stateVersion = "25.05";
    profile = ./g.nix;
  };
  "g@archlinux" = mkHome {
    username = "g";
    hostName = "archlinux";
    desktop = "hyprland";
    stateVersion = "25.11";
    profile = ./g.nix;
  };
}
