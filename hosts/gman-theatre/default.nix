{ self, pkgs, lib, ... }:
{

  imports = [
    ./disko.nix
    (self + /profiles/nixos/wg0.nix)
  ];
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
