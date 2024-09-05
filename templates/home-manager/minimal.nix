{ lib, ... }:
{
  stylix = {
    enable = lib.mkForce false;
    autoEnable = lib.mkForce false;
  };
  programs.gh.enable = false;
}
