{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption mkForce;
  cfg = config.programs.rmpc;
in
{
  options.programs.rmpc.imperativeConfig = mkEnableOption "imperative config for rmpc";
  config = {
    programs.rmpc.config = mkIf cfg.imperativeConfig (mkForce "");
    home.packages = mkIf cfg.enable [ pkgs.yt-dlp ];
  };
}
