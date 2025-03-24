{ lib, ... }:
let
  inherit (lib) mkDefault;
in
{
  mov-cli = {
    version = mkDefault 1;
    debug = mkDefault false;
    player = mkDefault "mpv";
    quality = mkDefault "auto";
    skip_update_checker = mkDefault false;
    auto_try_next_scraper = mkDefault true;
    hide_ip = mkDefault true;
  };

  mov-cli.plugins = mkDefault {
    test = "mov-cli-test";
    youtube = "mov-cli-youtube";
  };

  mov-cli.ui = {
    preview = mkDefault true;
    watch_options = mkDefault true;
    display_quality = mkDefault false;
  };

  mov-cli.http = {
    timeout = mkDefault 15;
  };
}
