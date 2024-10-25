{ lib, ... }:
let
  inherit (lib) mkDefault;
in
{
  services.dunst.settings = {
    global = {
      origin = mkDefault "bottom-right";
      timeout = mkDefault 3;
    };
  };
}
