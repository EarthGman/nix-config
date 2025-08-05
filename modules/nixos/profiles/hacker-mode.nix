# provides a number of cybersecurity tools
{
  pkgs,
  lib,
  config,
  ...
}@args:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.profiles.hacker-mode;
  desktop = if args ? desktop then args.desktop else null;
in
{
  options.profiles.hacker-mode.enable = mkEnableOption "cybersecurity suite";
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
