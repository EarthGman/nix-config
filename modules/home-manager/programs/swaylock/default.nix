{ pkgs, lib, ... }:
let
  inherit (lib) mkDefault;
in
{
  programs.swaylock = {
    package = mkDefault pkgs.swaylock-effects;
    settings = {
      effect-blur = mkDefault "33x1";
      clock = mkDefault true;
    };
  };
}
