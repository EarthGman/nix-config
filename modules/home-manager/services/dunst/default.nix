{ lib, config, ... }:
{
  options.custom.dunst.enable = lib.mkEnableOption "enable dunst notification daemon";
  config = lib.mkIf config.custom.dunst.enable {
    services.dunst = {
      enable = true;
    };
  };
}
