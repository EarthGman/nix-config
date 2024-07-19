{ pkgs, lib, config, username, ... }:
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
