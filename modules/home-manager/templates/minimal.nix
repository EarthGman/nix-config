{ lib, ... }:
{
  stylix = {
    enable = lib.mkForce false;
    autoEnable = lib.mkForce false;
  };
}
