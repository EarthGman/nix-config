{ lib, ... }:
let
  inherit (lib) mkDefault;
in
{
  programs.mcrcon.enable = mkDefault true;

  services.minecraft-server = {
    enable = true;
    eula = true;
    openFirewall = mkDefault true;
    dataDir = mkDefault "/opt/minecraft/server";
  };
}
