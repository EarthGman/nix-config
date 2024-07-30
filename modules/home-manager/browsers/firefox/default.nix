{ pkgs, lib, config, username, ... }:
# uses betterfox user.js by default
let
  betterfox = pkgs.fetchFromGitHub {
    owner = "yokoffing";
    repo = "Betterfox";
    rev = "main";
    sha256 = "i8cCSjPV/nuNFEgjhuLJUbdpT6flGxTacaQu78SXZis=";
  };
  user_js = "${betterfox}/user.js";
in
{
  options.firefox.enable = lib.mkEnableOption "firefox config";
  config = lib.mkIf config.firefox.enable {
    # TODO declarative browser theme
    home.file.".mozilla/firefox/${username}/user.js".source = user_js;
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
            default = lib.mkDefault "DuckDuckGo";
            engines = import ./search-engines.nix { inherit pkgs; };
            force = true;
          };
        };
      };
    };
  };
}
