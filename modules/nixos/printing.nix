{ pkgs, ... }:
# enables printing
{
  # searches the network for printers
  # be sure to allow UDP port 5353
  services.avahi = {
    enable = true;
    nssmdns = true;
    openFirewall = true;
  };

  services.printing.enable = true;

  # drivers
  services.printing.drivers = [
    pkgs.samsung-unified-linux-driver
  ];
}
