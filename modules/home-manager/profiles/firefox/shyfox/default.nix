# warning: the owner of this theme has deprecated the project
{
  pkgs,
  lib,
  config,
  ...
}@args:
let
  nixosConfig = if args ? nixosConfig then args.nixosConfig else null;
  cfg = config.gman.profiles.firefox.shyfox;

  # append the betterfox patch to the shyfox user_js
  betterfox_js = builtins.readFile (pkgs.betterfox + "/user.js");
in
{
  options.gman.profiles.firefox.shyfox = {
    enable = lib.mkEnableOption "shyfox theme for firefox";
    config = lib.mkOption {
      description = ''
        extra configuration for the shyfox theme
      '';
      default = { };
      type = lib.types.attrsOf lib.types.str;
    };
  };
  config = lib.mkIf cfg.enable {
    programs.firefox.profiles.default = {
      id = 0;
      extensions.packages = (
        builtins.attrValues {
          inherit (pkgs.nur.repos.rycee.firefox-addons)
            ublock-origin
            darkreader
            sidebery
            ;
        }
        ++ lib.optionals (nixosConfig != null && nixosConfig.programs._1password-gui.enable) [
          pkgs.nur.repos.rycee.firefox-addons.onepassword-password-manager
        ]
        ++ [
          pkgs.userchrome-toggle-extended
        ]
      );

      search = {
        default = lib.mkDefault "ddg"; # DuckDuckGo
        engines = import ../../../../../templates/search-engines.nix { inherit pkgs; };
        force = true;
      };
      # apply betterfox settings on top of shyfox
      extraConfig = builtins.readFile (pkgs.shyfox + "/user.js") + betterfox_js;
    };
    # apply the chrome patch, inheriting any configuration such as a different wallpaper
    home.file.".mozilla/firefox/default/chrome".source =
      if cfg.config != { } then
        (pkgs.shyfox.override { themeConfig = cfg.config; } + "/chrome")
      else
        (pkgs.shyfox + "/chrome");
  };
}
