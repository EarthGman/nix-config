{ pkgs, config, lib, ... }:
{
  options.steam.enable = lib.mkEnableOption "enable steam";
  config = lib.mkIf config.steam.enable {
    home.packages = with pkgs; [
      steam
    ];
  };
}
