{ lib, ... }:
let
  inherit (lib) mkDefault;
in
{
  services.kanshi = {
    systemdTarget = mkDefault "graphical-session.target";
  };
}

