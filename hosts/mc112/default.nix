# Vanilla MC 1.12.2
{ pkgs, lib, ... }:
{
  # join zerotier network
  services.zerotierone = {
    enable = true;
    joinNetworks = [
      "d5e5fb653723b80e"
    ];
  };

  users.users."root" = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKNRHd6NLt4Yd9y5Enu54fJ/a2VCrRgbvfMuom3zn5zg"
    ];
  };

  networking.firewall.allowedTCPPorts = [ 25565 ]; # minecraft port
  services.minecraft-server = {
    enable = true;
    eula = true;
    declarative = true;
    dataDir = "/opt/minecraft/server";
    # overrides jre_headless to use jre8 instead. This is because attempting to load server-icon.png causes a server crash from a missing library.
    package = pkgs.minecraftServers.vanilla-1-12.override { jre_headless = pkgs.jre8; };
    serverProperties = import ./server-properties.nix;
    whitelist = import ./whitelist.nix;
    jvmOpts = lib.concatStringsSep " " [
      "-Xmx8g"
      "-Xms8g"
      "-XX:+UseG1GC"
      "-Dlog4j2.formatMsgNoLookups=true"
      "-Dsun.rmi.dgc.server.gcInterval=600000"
      "-XX:+UnlockExperimentalVMOptions"
      "-XX:+DisableExplicitGC"
      "-XX:G1NewSizePercent=20"
      "-XX:G1ReservePercent=20"
      "-XX:MaxGCPauseMillis=50"
      "-XX:G1HeapRegionSize=32"
      "-Dfml.ignorePatchDiscrepancies=true"
      "-Dfml.ignoreInvalidMinecraftCertificates=true"
      "-Dmfl.readTimout=180"
    ];
  };
}
