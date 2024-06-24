{ pkgs, ... }:
{
  imports = [
    ../../templates/prox-server
  ];

  networking.firewall.allowedTCPPorts = [ 25565 ];

  environment.systemPackages = with pkgs; [
    jre8_headless
  ];

  services.minecraft-server = {
    enable = true;
    eula = true;
    declarative = true;
    dataDir = "/opt/minecraft/server";
    package = pkgs.minecraftServers.vanilla-1-12;
    serverProperties = import ./server-properties.nix;
    whitelist = import ./whitelist.nix;
    jvmOpts = "-Xmx8g -Xms8g -XX:+UseG1GC -Dlog4j2.formatMsgNoLookups=true -Dsun.rmi.dgc.server.gcInterval=600000 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:G1NewSizePercent=20 -XX:G1ReservePercent=20 -XX:MaxGCPauseMillis=50 -XX:G1HeapRegionSize=32 -Dfml.ignorePatchDiscrepancies=true -Dfml.ignoreInvalidMinecraftCertificates=true -Dmfl.readTimout=180";    
  };
}
