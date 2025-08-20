{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.gman.profiles.eww.default;
in
{
  options.gman.profiles.eww.default = {
    enable = lib.mkEnableOption "default eww config";
  };

  config = lib.mkIf cfg.enable {
    # TODO eww config
  };
}
