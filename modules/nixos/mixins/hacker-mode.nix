# provides a number of cybersecurity tools
{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.gman.hacker-mode;
in
{
  options.gman.hacker-mode.enable = lib.mkEnableOption "gman's cybersecurity suite";
  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      (lib.mkIf (config.meta.desktop != "") {
        programs = {
          ghidra.enable = lib.mkDefault true;
          burpsuite.enable = lib.mkDefault true;
          zenmap.enable = lib.mkDefault true;
          wireshark.package = pkgs.wireshark; # install gui version if desktop is enabled
        };
      })
      {
        programs = {
          tcpdump.enable = true;

          wireshark.enable = true;
          nmap.enable = true;
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
      }
    ]
  );
}
