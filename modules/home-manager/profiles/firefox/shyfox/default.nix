# warning: the owner of this theme has deprecated the project
{
  pkgs,
  lib,
  config,
  ...
}@args:
let
  icons = if args ? icons then args.icons else null;
  inherit (lib) mkEnableOption mkIf mkDefault;
  cfg = config.profiles.firefox.shyfox;
in
{
  options.profiles.firefox.shyfox.enable = mkEnableOption "shyfox theme for firefox";
  config = mkIf cfg.enable {
    programs.firefox.profiles.default = {
      id = 0;
      extensions.packages =
        (with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          onepassword-password-manager
          darkreader
          sidebery
        ])
        ++ (with pkgs; [
          userchrome-toggle-extended
        ]);
      search = {
        default = mkDefault "ddg"; # DuckDuckGo
        engines = import ../search-engines.nix { inherit pkgs icons; };
        force = true;
      };
      extraConfig = builtins.readFile (pkgs.shyfox + "/user.js");
    };
    # apply the chrome patch, inheriting any configuration such as a different wallpaper
    home.file.".mozilla/firefox/default/chrome".source =
      let
        cfg = config.programs.firefox.themes.shyfox;
      in
      if cfg.config != { } then
        (pkgs.shyfox.override { themeConfig = cfg.config; } + "/chrome")
      else
        (pkgs.shyfox + "/chrome");
  };
}
