{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkDefault mkIf;
in
{
  options.modules.openvpn.enable = mkEnableOption "openvpn desktop module";
  config = mkIf config.modules.openvpn.enable {
    networking.networkmanager.plugins = [ pkgs.networkmanager-openvpn ];
    programs = {
      openvpn3 = {
        enable = mkDefault true;
      };
    };
    environment.systemPackages = [ pkgs.openvpn ];
  };
}
