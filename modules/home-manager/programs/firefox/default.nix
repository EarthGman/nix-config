{ icons, pkgs, lib, config, ... }:
let
  inherit (lib) types mkIf mkDefault mkOption;
  profile = ".mozilla/firefox/default";
  cfg = config.programs.firefox;
in
{
  options.programs.firefox = {
    theme = {
      name = mkOption {
        description = "name of theme";
        type = types.str;
        default = "betterfox";
      };
      config = mkOption {
        description = ''
          any extra configuration for themes such as setting of wallpapers.
        '';
        default = { };
        type = types.attrsOf types.str;
      };
    };
  };
  config =
    let
      themePackage =
        if (builtins.hasAttr "${cfg.theme.name}" pkgs) then
          pkgs."${cfg.theme.name}".override
            {
              themeConfig = cfg.theme.config;
            }
        else
          null;
    in
    mkIf cfg.enable {
      programs.firefox = {
        profiles = {
          "default" = {
            id = 0;
            extensions.packages = (with pkgs.nur.repos.rycee.firefox-addons; [
              ublock-origin
              onepassword-password-manager
              darkreader
              sidebery
            ]) ++ (with pkgs; [
              userchrome-toggle-extended
            ]);
            search = {
              default = mkDefault "ddg"; # DuckDuckGo
              engines = import ./search-engines.nix { inherit pkgs icons; };
              force = true;
            };
            extraConfig =
              if builtins.pathExists (themePackage + "/user.js") then
                builtins.readFile (themePackage + "/user.js")
              else "";
          };
        };
      };
      home.file."${profile}/chrome" = mkIf (builtins.pathExists (themePackage + "/chrome")) {
        source = themePackage + "/chrome";
      };
    };
}
