{ pkgs, lib, config, username, search-engine, ... }:
# search engine defaults to duckduckgo
let
  profileDir = ".mozilla/firefox/${username}";
  shyFoxRepo = pkgs.fetchFromGitHub {
    owner = "Naezr";
    repo = "ShyFox";
    rev = "main";
    sha256 = "04zwfacnz3wfmabmbawgg523s6qyxszjcafgl2qahn1j30rsxxl1";
  };
  user_js = "${shyFoxRepo}/user.js";
  chrome = "${shyFoxRepo}/chrome";
in
{
  options.firefox.enable = lib.mkEnableOption "enable firefox";
  config = lib.mkIf config.firefox.enable {
    home.file = {
      "${profileDir}/chrome".source = chrome;
      "${profileDir}/user.js".source = user_js;
    };
    programs.firefox = {
      enable = true;
      profiles = {
        "${config.home.username}" = {
          id = 0;
          extensions = (with pkgs.nur.repos.rycee.firefox-addons; [
            ublock-origin
            onepassword-password-manager
            darkreader
            sidebery
          ]) ++ (with pkgs; [
            userchrome-toggle-extended
          ]);
          search = {
            default = search-engine;
            engines = import ./search-engines.nix { inherit pkgs; };
            force = true;
          };
        };
      };
    };
  };
}
