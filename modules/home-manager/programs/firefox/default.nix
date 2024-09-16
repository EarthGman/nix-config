{ icons, pkgs, lib, config, ... }:
# uses betterfox user.js by default
let
  inherit (lib) types mkIf mkDefault mkOption mkEnableOption;
  profile = ".mozilla/firefox/default";
  cfg = config.programs.firefox;
  betterfox = pkgs.fetchFromGitHub {
    owner = "yokoffing";
    repo = "Betterfox";
    rev = "main";
    sha256 = "sha256-hpkEO5BhMVtINQG8HN4xqfas/R6q5pYPZiFK8bilIDs=";
  };
  user_js = "${betterfox}/user.js";
in
{
  options.programs.firefox = {
    theme = {
      name = mkOption {
        description = "name of theme";
        type = types.str;
        default = "";
      };
      config = mkOption {
        description = ''
          extra config passed to theme derivtaion
        '';
        default = { };
        type = types.attrsOf types.str;
      };
    };
  };
  config =
    let
      packageName = cfg.theme.name;
      themePackage =
        if (packageName != "") then
          pkgs."${packageName}".override
            {
              themeConfig = cfg.theme.config;
            } else null;
    in
    mkIf cfg.enable {
      programs.firefox = {
        profiles = {
          "default" = {
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
              default = mkDefault "DuckDuckGo";
              engines = import ./search-engines.nix { inherit pkgs icons; };
              force = true;
            };
            extraConfig =
              if (themePackage != null) then
                (builtins.readFile (themePackage + "/user.js"))
              else builtins.readFile user_js;
          };
        };
      };
      home.file."${profile}/chrome" = mkIf (themePackage != null) {
        source = themePackage + "/chrome";
      };
    };
}
