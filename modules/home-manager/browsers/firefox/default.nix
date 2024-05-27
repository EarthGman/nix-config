{ pkgs, lib, config, username, search-engine, ... }:
let
  user_js = config.home.homeDirectory + "/src/nix-config/modules/home-manager/browsers/firefox/user.js";
in
{
  options.firefox.enable = lib.mkEnableOption "enable firefox";
  config = lib.mkIf config.firefox.enable {
    # implements the betterfox patch
    home = {
      file = {
        ".mozilla/firefox/${username}/user.js".source = config.lib.file.mkOutOfStoreSymlink user_js;
      };
    };
    programs.firefox = {
      enable = true;
      profiles = {
        "${config.home.username}" = {
          id = 0;
          extensions = with pkgs.nur.repos.rycee.firefox-addons; [
            ublock-origin
            onepassword-password-manager
            darkreader
          ];
          search = {
            default = search-engine;
            force = true;
          };
        };
      };
    };
  };
}
