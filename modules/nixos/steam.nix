{ pkgs, lib, config, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.custom.steam;
in
{
  options.custom.steam = {
    enable = mkEnableOption "enables the steam module";
    remotePlay = mkEnableOption "enable steam remote play";
    dedicatedServer = mkEnableOption "enable dedicated server for steam";
    gameTransfers = mkEnableOption "enable steam game transfers for LAN";
  };
  config = mkIf cfg.enable {
    programs = {
      gamemode.enable = true;
      steam = {
        enable = true;
        gamescopeSession = {
          enable = true;
        };
        remotePlay.openFirewall = cfg.remotePlay; # Open ports in the firewall for Steam Remote Play
        dedicatedServer.openFirewall = cfg.dedicatedServer; # Open ports in the firewall for Source Dedicated Server
        localNetworkGameTransfers.openFirewall = cfg.gameTransfers; # Open ports in the firewall for Steam Local Network Game Transfers
      };
    };
    environment = {
      systemPackages = with pkgs; [
        mangohud
        protonup
      ];
      sessionVariables = {
        STEAM_EXTRA_COMPAT_TOOLS_PATHS = "~/.steam/root/compatibilitytools.d";
      };
    };
  };
}
