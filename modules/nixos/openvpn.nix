{ pkgs, config, lib, ... }:
{
  options.custom.openvpn.enable = lib.mkEnableOption "enable openvpn";
  config = lib.mkIf config.custom.openvpn.enable {
    environment.systemPackages = [
      pkgs.openvpn
    ];
    networking.firewall.allowedUDPPorts = [ 1194 ];
  };
}
