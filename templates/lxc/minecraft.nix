{ lib, ... }:
let
  inherit (lib) mkDefault;
in
{
  services.minecraft-server = {
    enable = true;
    eula = true;
    openFirewall = mkDefault true;
    dataDir = mkDefault "/opt/minecraft/server";
  };
}
