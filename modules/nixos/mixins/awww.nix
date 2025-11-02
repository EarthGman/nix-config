{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.gman.awww;
in
{
  options.gman.awww = {
    enable = lib.mkEnableOption "gman's awww service configuration";
  };

  config = lib.mkIf cfg.enable {
    services.awww = {
      enable = lib.mkDefault true;
      flags = [
        "-f"
        "argb"
      ];
    };
  };
}
