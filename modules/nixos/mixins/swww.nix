{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.gman.swww;
in
{
  options.gman.swww = {
    enable = lib.mkEnableOption "gman's swww service configuration";
  };

  config = lib.mkIf cfg.enable {
    services.swww = {
      enable = lib.mkDefault true;
      flags = [
        "-f"
        "argb"
      ];
    };
  };
}
