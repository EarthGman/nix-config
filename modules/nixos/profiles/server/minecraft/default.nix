{ lib, config, ... }:
let
  inherit (lib) mkDefault mkEnableOption mkIf;
  cfg = config.profiles.server.minecraft;
in
{
  options.profiles.server.minecraft.enable = mkEnableOption "minecraft server profile";
  config = mkIf cfg.enable {
    programs.mcrcon.enable = mkDefault true;

    services.minecraft-server = {
      enable = true;
      eula = true;
      openFirewall = mkDefault true;
      dataDir = mkDefault "/opt/minecraft/server";
    };
  };
}
