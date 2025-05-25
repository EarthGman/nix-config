{ inputs, lib, system, ... }:
let
  inherit (lib) mkDefault;
in
{
  #latest version of ghostty
  programs.ghostty = {
    package = mkDefault inputs.ghostty.packages.${system}.default;
    settings = {
      gtk-titlebar = mkDefault false;
    };
  };
}
