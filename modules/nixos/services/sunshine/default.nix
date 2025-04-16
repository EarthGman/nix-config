{ lib, ... }:
let
  inherit (lib) mkDefault;
in
{
  services.sunshine = {
    openFirewall = mkDefault true;
    capSysAdmin = mkDefault true;
  };
}
