# installs a number of cybersecurity tools installed at the system level
# for larger programs other than wireshark (ghidra, burpsuite, etc) add them through home-manager
{ pkgs, lib, desktop, ... }:
{
  programs.wireshark = {
    enable = true;
    package = lib.mkIf (desktop != null) pkgs.wireshark; # install gui version if desktop is enabled
  };

  environment.systemPackages = with pkgs; [
    gcc
    python3

    binutils
    busybox
    nmap
    dig
    tcpdump
  ];
}
