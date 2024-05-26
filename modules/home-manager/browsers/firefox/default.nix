{ pkgs, config, ... }:
let
  user_js = config.home.homeDirectory + "/src/nix-config/modules/home-manager/browsers/firefox/user.js";
in
{
  # implements the betterfox patch
  home = {
    file = {
      ".mozilla/firefox/${config.home.username}/user.js".source = config.lib.file.mkOutOfStoreSymlink user_js;
    };
  };
  programs.firefox = {
    enable = true;
    profiles = {
      "${config.home.username}" = {
        id = 0;
        #extensions = with inputs.firefox-addons.packages.${pkgs.system}; [
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          onepassword-password-manager
          darkreader
        ];
        search = {
          default = "DuckDuckGo";
          force = true;
        };
      };
    };
  };
}
