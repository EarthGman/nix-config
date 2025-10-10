{
  inputs,
  lib,
  ...
}:
{
  "g@archlinux" = lib.mkHome {
    username = "g";
    hostname = "archlinux";
    desktop = "hyprland";
    stateVersion = "25.11";
    profile = ./g;
    extraExtraSpecialArgs = { inherit inputs; };
  };
}
