{ lib, ... }:
let
  inherit (lib) mkDefault;
in
{
  services.dunst.settings = {
    global = {
      monitor = mkDefault 0;
      origin = mkDefault "bottom-right";
      timeout = mkDefault 3;
    };
  };
}
