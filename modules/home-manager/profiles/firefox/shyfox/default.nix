# warning: the owner of this theme has deprecated the project
{
  pkgs,
  lib,
  config,
  ...
}@args:
let
  icons = if args ? icons then args.icons else null;
  nixosConfig = if args ? nixosConfig then args.nixosConfig else null;
  inherit (lib)
    mkEnableOption
    mkIf
    mkDefault
    mkOption
    optionals
    types
    ;
  cfg = config.profiles.firefox.shyfox;

  # append the betterfox patch to the shyfox user_js
  betterfox_js = builtins.readFile (pkgs.betterfox + "/user.js");
in
{
  options.profiles.firefox.shyfox = {
    enable = mkEnableOption "shyfox theme for firefox";
    config = mkOption {
      description = ''
        extra configuration for the shyfox theme
      '';
      default = { };
      type = types.attrsOf types.str;
    };
  };
  config = mkIf cfg.enable {
    programs.firefox.profiles.default = {
      id = 0;
      extensions.packages =
        (
          with pkgs.nur.repos.rycee.firefox-addons;
          [
            ublock-origin
            darkreader
            sidebery
          ]
          ++ optionals (nixosConfig != null && nixosConfig.programs._1password-gui.enable) [
            onepassword-password-manager
          ]
        )
        ++ (with pkgs; [
          userchrome-toggle-extended
        ]);
      search = {
        default = mkDefault "ddg"; # DuckDuckGo
        engines = import ../search-engines.nix { inherit pkgs icons; };
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
