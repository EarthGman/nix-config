{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    git
    gparted
    wget
    file
    zip
    unzip
    home-manager
  ];

  services.usbmuxd = {
    enable = true;
    package = pkgs.usbmuxd2;
  };
}
