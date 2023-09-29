{config, pkgs, ...}:
let
  firefox-addons = pkgs.nur.repos.rycee.firefox-addons;
in
{
  programs.firefox = {
    enable = true;
    profiles = {
      "${config.home.username}" = {
        id = 0;
        extensions = (with firefox-addons; [
         ublock-origin 
         onepassword-password-manager
         darkreader
        ]);
        search.default = "DuckDuckGo";
        search.force = true;
      };
    };
  };
}