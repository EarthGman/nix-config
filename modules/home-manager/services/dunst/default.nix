{ lib, ... }:
let
  inherit (lib) mkDefault;
in
{
  imports = [ ./battery-monitor.nix ];
  services.dunst.settings = {
    global = {
      monitor = mkDefault 0;
      origin = mkDefault "bottom-right";
      timeout = mkDefault 3;
      frame_width = mkDefault 0;
      gap_size = mkDefault 3; # add small gap between notifications
      idle_threshold = mkDefault 30;
    };
  };
}
