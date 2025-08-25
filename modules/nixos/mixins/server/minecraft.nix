{ lib, config, ... }:
let
  cfg = config.gman.server.minecraft;
in
{
  options.gman.server.minecraft.enable = lib.mkEnableOption "gman's minecraft server config";
  config = lib.mkIf cfg.enable {
    programs.mcrcon.enable = lib.mkDefault true;

    services.minecraft-server = {
      enable = true;
      eula = true;
      openFirewall = lib.mkDefault true;
      dataDir = lib.mkDefault "/srv";
    };
  };
}
