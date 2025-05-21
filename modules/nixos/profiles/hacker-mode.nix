# provides a number of cybersecurity tools installed at the system level
{ pkgs, lib, config, desktop ? null, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.profiles.hacker-mode;
in
{
  options.profiles.hacker-mode.enable = mkEnableOption "hacker suite";
  config = mkIf cfg.enable {
    programs = {
      tcpdump = {
        enable = true;
      };
      wireshark = {
        enable = true;
        package = mkIf (desktop != null) pkgs.wireshark; # install gui version if desktop is enabled
      };
      ghidra.enable = (desktop != null);
      burpsuite.enable = (desktop != null);
    };

    environment.systemPackages = with pkgs; [
      gcc
      python3
      binutils
      busybox
      nmap
      dig
    ];
  };
}
