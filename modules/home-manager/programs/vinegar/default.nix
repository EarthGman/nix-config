{ pkgs, lib, config, ... }:
let
  cfg = config.programs.vinegar;
  inherit (lib) mkIf;
in
{
  config = mkIf cfg.enable {
    home.packages = with pkgs; [ wine64 samba ]; # sambda needed for ntlm_auth
  };
}
