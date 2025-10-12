{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.gman.desktop-theme-sync;
  users = builtins.attrNames config.home-manager.users;
  theme =
    # disable if user is empty string
    if (cfg.config.user != "") then
      config.home-manager.users.${cfg.config.user}.meta.profiles.desktopTheme
    else
      null;
in
{
  options.gman.desktop-theme-sync = {
    enable = lib.mkEnableOption "synchronization between desktop themes in home-manager and stylization with nixos (such as the theming of display-managers or bootloaders)";

    config.user = lib.mkOption {
      description = "which user's theme config should control the style of system components";
      type = lib.types.str;
      # depends on how users appear alphabetically in the home-manager.users attrset but will work for 0 or 1 home-manager user systems
      default = if (users != [ ]) then builtins.elemAt users 0 else "";
    };
  };

  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      (lib.mkIf (theme == "astronaut") (import ./astronaut))
      (lib.mkIf (theme == "the-world-machine") (import ./the-world-machine { inherit pkgs; }))
      (lib.mkIf (theme == "cozy-undertale") (import ./cozy-undertale { inherit pkgs; }))
      (lib.mkIf (theme == "omori-faraway") (import ./omori-faraway { inherit pkgs; }))
    ]
  );
}
