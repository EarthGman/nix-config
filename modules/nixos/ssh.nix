{ config, lib, ... }:
{
  options.custom.ssh.enable = lib.mkEnableOption "enable ssh daemon";
  config = lib.mkIf config.custom.ssh.enable {
    services = {
      sshd.enable = true;
      openssh = {
        enable = true;
        settings.PasswordAuthentication = lib.mkDefault true;
      };
    };
    networking.firewall.allowedTCPPorts = [ 22 ];
  };
}
