{ pkgs, config, lib, ... }:
{
  options.thunderbird.enable = lib.mkEnableOption "enable thunderbird";
  config = lib.mkIf config.thunderbird.enable {
    home.packages = with pkgs; [
      thunderbird
    ];
  };
}
