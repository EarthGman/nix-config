{ pkgs, lib, hostname, ... }:
let
  hasSamsungPrinter = (hostname == "cypher" || hostname == "garth");
  ownsSamsungCLX3175FW = (hostname == "cypher" || hostname == "garth");
in
{
  # searches the network for printers
  # be sure to allow UDP port 5353
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
  services.printing.enable = true;

  # drivers
  services.printing.drivers = with pkgs; lib.optionals hasSamsungPrinter [
    samsung-unified-linux-driver
  ];

  # printers
  hardware.printers = {
    ensurePrinters = lib.optionals ownsSamsungCLX3175FW [
      {
        # printer downstairs
        name = "SamsungCLX3175FW";
        location = "Home";
        deviceUri = "http://192.168.72.21:631";
        model = "samsung/CLX-3170.ppd";
        ppdOptions = {
          PageSize = "Letter";
        };
      }
    ];
  };
}
