{ lib, config, ... }:
let
  inherit (lib) mkDefault mkIf mkEnableOption;
  cfg = config.modules.zsa-keyboard;
in
{
  options.modules.zsa-keyboard.enable = mkEnableOption "enable zsa configuration module";
  config = mkIf cfg.enable {
    hardware.keyboard.zsa.enable = true;
    programs.keymapp.enable = mkDefault true;
  };
}
