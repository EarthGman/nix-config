{ pkgs, lib, config, ... }:
{
  options.modules.zsa-keyboard.enable = lib.mkEnableOption "enable zsa configuration module";
  config = lib.mkIf config.modules.zsa-keyboard.enable {
    hardware.keyboard.zsa.enable = true;
    environment.systemPackages = with pkgs; [
      keymapp
    ];
  };
}

