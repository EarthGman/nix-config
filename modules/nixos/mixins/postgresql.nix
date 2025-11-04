# this module was created for a school assignment and will probably be removed in the near future
{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.gman.postgresql;
in
{
  options.gman.postgresql.enable = lib.mkEnableOption "gman's postgres config";

  config = lib.mkIf cfg.enable {
    services.postgresql = {
      enable = true;
      enableTCPIP = true;
      authentication = lib.mkForce ''
        #type database DBuser origin-address auth-method
        local all      all     trust
        # ... other auth rules ...

        # ipv4
        host  all      all     127.0.0.1/32   trust
        # ipv6
        host  all      all     ::1/128        trust
      '';
    };

    environment.systemPackages = [
      pkgs.pgcli
    ];
  };
}
