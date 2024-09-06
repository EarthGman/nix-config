{ pkgs, config, lib, ... }:
{
  options.custom.thunderbird.enable = lib.mkEnableOption "enable thunderbird";
  config = lib.mkIf config.custom.thunderbird.enable {
    home.packages = with pkgs; [
      thunderbird
    ];
  };
}
