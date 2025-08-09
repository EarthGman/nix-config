{
  self,
  inputs,
  lib,
  ...
}:
{
  "g@archlinux" = lib.mkHome {
    username = "g";
    hostName = "archlinux";
    desktop = "hyprland";
    stateVersion = "25.11";
    profile = ./g;
    extraExtraSpecialArgs = { inherit self inputs; };
  };
}
