{ inputs, lib, config, system, ... }:
let
  inherit (lib) mkDefault;
in
{
  #latest version of ghostty
  programs.ghostty = {
    enable = mkDefault (config.custom.terminal == "ghostty");
    package = mkDefault inputs.ghostty.packages.${system}.default;
    settings = {
      gtk-titlebar = mkDefault false;
    };
  };
}
