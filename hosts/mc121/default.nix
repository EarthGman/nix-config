{ pkgs, lib, outputs, ... }:
{
  users.users."root" = {
    openssh.authorizedKeys.keys = [ outputs.keys.g_pub ];
  };

  networking.firewall.allowedTCPPorts = [ 25567 ];
  services.minecraft-server = {
    enable = true;
    package = pkgs.minecraftServers.vanilla-1-21;
    # package = pkgs.minecraftServers.vanilla-1-21.overrideAttrs (old: {
    #   src = builtins.fetchurl binaries.purpur-121;
    # });
    eula = true;
    declarative = true;
    dataDir = "/opt/minecraft/server";
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
