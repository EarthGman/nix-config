{ pkgs, lib, ... }:
{

  imports = [
    ./disko.nix
  ];

  profiles.gman = {
    wireguard.wg0.enable = true;
    server.enable = true;
  };

  modules.nh.enable = false;

  hardware.enableRedistributableFirmware = lib.mkForce true;
  networking.interfaces."eno1".wakeOnLan.enable = true;

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
