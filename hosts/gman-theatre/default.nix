{ pkgs, lib, ... }:
{

  imports = [
    ./disko.nix
  ];

  profiles.wg0.enable = true;
  profiles.server.personal.enable = true;

  modules.nh.enable = false;
  modules.sops.enable = true;


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
