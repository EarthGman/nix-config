{ config, pkgs, inputs, ... }:
let
  user_js = config.home.homeDirectory + "/src/nix-config/modules/home-manager/firefox/user.js";
in
{
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
        extensions = with pkgs.inputs.firefox-addons; [
          ublock-origin
          onepassword-password-manager
          darkreader
        ];
        search.default = "DuckDuckGo";
        search.force = true;
      };
    };
  };
}
