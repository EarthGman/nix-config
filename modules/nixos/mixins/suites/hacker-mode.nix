# provides a number of cybersecurity tools
{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.gman.suites.hacker-mode;
in
{
  options.gman.suites.hacker-mode.enable = lib.mkEnableOption "gman's cybersecurity suite";
  config = lib.mkIf cfg.enable {
    programs = {
      tcpdump = {
        enable = true;
      };
      wireshark = {
        enable = true;
        package = lib.mkIf (config.meta.desktop != "") pkgs.wireshark; # install gui version if desktop is enabled
      };
      ghidra.enable = (config.meta.desktop != "");
      burpsuite.enable = (config.meta.desktop != "");
    };

    environment.systemPackages = builtins.attrValues {
      inherit (pkgs)
        gcc
        python3
        binutils
        busybox
        nmap
        dig
        ;
    };
  };
}
