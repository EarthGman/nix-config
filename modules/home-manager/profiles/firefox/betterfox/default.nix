{ pkgs, lib, config, ... }@args:
let
  icons = if args ? icons then args.icons else null;
  inherit (lib) mkDefault mkIf mkEnableOption;
  cfg = config.profiles.firefox.betterfox;
in
{
  options.profiles.firefox.betterfox.enable = mkEnableOption "betterfox patch to firefox";
  config = mkIf cfg.enable {
    programs.firefox.profiles.default = {
      id = 0;
      extensions.packages = (with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
        onepassword-password-manager
        darkreader
        sidebery
      ]);
      search = {
        default = mkDefault "ddg"; # DuckDuckGo
        engines = import ../search-engines.nix { inherit pkgs icons; };
        force = true;
      };

      extraConfig = builtins.readFile (pkgs.betterfox + "/user.js");
    };
  };
}
