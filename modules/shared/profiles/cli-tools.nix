{ lib, config, ... }:
let
  inherit (lib) mkEnableOption mkIf mkDefault;
  cfg = config.profiles.cli-tools;
  enabled = {
    enable = mkDefault true;
  };
in
{
  options.profiles.cli-tools.enable = mkEnableOption "basic cli-tools";
  config = mkIf cfg.enable {
    programs = {
      btop = enabled;
      sysz = enabled;
      hstr = enabled;
      fd = enabled;
      jq = enabled;
      ncdu = enabled;
      lynx = enabled;
      ripgrep = enabled;
    };
  };
}
