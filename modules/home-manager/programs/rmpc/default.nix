{ pkgs, lib, config, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.rmpc;
in
{
  home.packages = mkIf cfg.enable [ pkgs.yt-dlp ];
}
