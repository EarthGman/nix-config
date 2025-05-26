{ pkgs, lib, config, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.rmpc;
in
{
  home.packages = mkIf cfg.enable [ pkgs.yt-dlp ];
  programs.rmpc.config = ''
    (
      cache_dir: Some("${config.home.homeDirectory}/.cache/rmpc"),
    )
  '';
}
