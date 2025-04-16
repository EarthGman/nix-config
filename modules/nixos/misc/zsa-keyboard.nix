{ pkgs, lib, config, ... }:
let
  inherit (lib) mkDefault;
in
{
  options.modules.zsa-keyboard.enable = lib.mkEnableOption "enable zsa configuration module";
  config = lib.mkIf config.modules.zsa-keyboard.enable {
    hardware.keyboard.zsa.enable = true;
    programs.keymapp.enable = mkDefault true;
  };
}

