{ lib, ... }:
let
  inherit (lib) mkOption types;
in
{
  options = {
    # custom option allows various configuration to reference your preferred program to execute.
    # for example keybinds for Tiling Window Managers will open a browser or file manager based on what you set here.
    custom = {
      editor = mkOption {
        description = "String that will be exported 1:1 to your EDITOR env variable in your shell";
        type = types.str;
        default = "nvim";
      };
      terminal = mkOption {
        description = "which terminal emulator is used by default";
        type = types.str;
        default = "kitty";
      };
      fileManager = mkOption {
        description = "preferred fileManager";
        type = types.str;
        default = "nautilus";
      };
      browser = mkOption {
        description = "preferred browser";
        type = types.str;
        default = "firefox";
      };
    };
  };
}
