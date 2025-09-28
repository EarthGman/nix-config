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
      ensureDatabases = [ "default" ];
      authentication = lib.mkForce ''
        #type database  DBuser  auth-method
        local all       all     trust
      '';
    };

    environment.systemPackages = [
      pkgs.pgcli
    ];
  };
}
