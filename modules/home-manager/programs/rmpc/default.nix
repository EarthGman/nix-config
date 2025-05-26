{ config, ... }:
{
  programs.rmpc.config = ''
    (
      cache_dir: Some("${config.home.homeDirectory}/.cache/rmpc"),
    )
  '';
}
