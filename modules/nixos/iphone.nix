# utilities for iphones
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    ifuse # filesystem mount for iphones
    libimobiledevice # required
    checkra1n # jailbreaker
    usbmuxd
  ];

  services.usbmuxd = {
    enable = true;
    package = pkgs.usbmuxd2;
  };
}
