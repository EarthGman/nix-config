{ config, lib, ... }:
let
  cfg = config.modules.ssh;
in
{
  options.modules.ssh.enable = lib.mkEnableOption "enable ssh daemon";
  config = lib.mkIf cfg.enable {
    services = {
      sshd.enable = true;
    };
    networking.firewall.allowedTCPPorts = [ 22 ];
  };
}
