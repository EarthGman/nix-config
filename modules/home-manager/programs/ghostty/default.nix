{ inputs, lib, config, platform, ... }:
let
  inherit (lib) mkDefault;
in
{
  #latest version of ghostty
  programs.ghostty = {
    enable = (config.custom.terminal == "ghostty");
    package = mkDefault inputs.ghostty.packages.${platform}.default;
    settings = {
      background-opacity = mkDefault 0.87;
      gtk-titlebar = mkDefault false;
    };
  };
}
