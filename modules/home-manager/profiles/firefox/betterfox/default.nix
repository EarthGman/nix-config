{
  pkgs,
  lib,
  config,
  ...
}@args:
let
  nixosConfig = if args ? nixosConfig then args.nixosConfig else null;
  cfg = config.gman.profiles.firefox.betterfox;
in
{
  options.gman.profiles.firefox.betterfox.enable = lib.mkEnableOption "betterfox";
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
      );
      search = {
        default = lib.mkDefault "ddg"; # DuckDuckGo
        engines = import ../../../../../mixins/search-engines.nix { inherit pkgs; };
        force = true;
      };

      extraConfig = builtins.readFile (pkgs.betterfox + "/user.js");
    };
  };
}
