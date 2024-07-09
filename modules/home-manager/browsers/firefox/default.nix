{ pkgs, lib, username, browser-theme, search-engine, ... }:
# uses betterfox user.js by default
let
  betterfox = pkgs.fetchFromGitHub {
    owner = "yokoffing";
    repo = "Betterfox";
    rev = "main";
    sha256 = "1xpd5zxb3i03pzx209rn46vpsj4cd9z8brcyb2ilafafm1dz39wb";
  };
  user_js = "${betterfox}/user.js";
in
{
  imports = lib.optionals (browser-theme != null) [
    # TODO declarative browser theme
    ./themes/${browser-theme}
  ];
  home.file.".mozilla/firefox/g/user.js".source = user_js;
  programs.firefox = {
    enable = true;
    profiles = {
      "${username}" = {
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
          # search engine defaults to duckduckgo
          default = search-engine;
          engines = import ./search-engines.nix { inherit pkgs; };
          force = true;
        };
      };
    };
  };
}
