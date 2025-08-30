{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.gman.openvpn.enable = lib.mkEnableOption "gman's openvpn desktop module";

  config = lib.mkIf config.gman.openvpn.enable {
    networking.networkmanager.plugins = [ pkgs.networkmanager-openvpn ];
    programs = {
      # doesn't build 8-30-2025
      # openvpn3 = {
      #   enable = lib.mkDefault true;
      # };
    };
    environment.systemPackages = [ pkgs.openvpn ];
  };
}
