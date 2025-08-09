{ lib, config, ... }:
{
  options.gman.profiles.firefox.stock.enable =
    lib.mkEnableOption "stock firefox, indepedent of home-manager";

  config = lib.mkIf config.gman.profiles.firefox.stock.enable {
    programs.firefox.imperativeConfig = true;
  };
}
