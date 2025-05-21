{ pkgs, lib, config, ... }:
let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.profiles.gmans-keymap;
in
{
  options.profiles.gmans-keymap.enable = mkEnableOption "my personal keymap";
  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.keyd ];
    services.keyd = {
      enable = true;
      keyboards = {
        default = {
          ids = [ "*" ];
          settings = {
            main = {
              capslock = "overload(meta, esc)";
              leftalt = "layer(nav)";
            };
            "nav:A" = {
              h = "left";
              j = "down";
              k = "up";
              l = "right";
            };
          };
        };
      };
    };
  };
}
