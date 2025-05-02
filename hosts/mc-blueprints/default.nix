{ pkgs, inputs, outputs, lib, ... }:
let
  binaries = builtins.fromJSON (builtins.readFile inputs.binaries.outPath);
in
{
  services.minecraft-server = {
    # overrides jre_headless to use jre8 instead. This is because attempting to load server-icon.png causes a server crash from a missing library.
    package =
      let
        override = pkgs.minecraftServers.vanilla-1-12.override {
          jre_headless = pkgs.jre8;
        };
      in
      # carpetmod112
      override.overrideAttrs (old: {
        src = builtins.fetchurl binaries.carpet_server_112;
      });

    serverProperties = import ./server-properties.nix;
    whitelist = import ./whitelist.nix;
    jvmOpts = lib.concatStringsSep " " [
      "-Xmx2g"
      "-Xms2g"
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
