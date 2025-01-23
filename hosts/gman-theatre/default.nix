{ pkgs, lib, ... }:
{

  imports = [
    ./disko.nix
  ];
  modules.nh.enable = false;

  hardware.enableRedistributableFirmware = lib.mkForce true;

  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };
  services.jellyseerr = {
    enable = true;
    openFirewall = true;
  };

  environment.systemPackages = with pkgs; [
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
    libbluray
    dvdbackup
    handbrake
  ];
}
