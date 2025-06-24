{ lib, ... }:
let
  inherit (lib) mkDefault;
in
{
  programs.ghostty = {
    settings = {
      gtk-titlebar = mkDefault false;
    };
  };
}
