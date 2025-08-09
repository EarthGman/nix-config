{
  lib,
  config,
  ...
}:
let
  program-name = "piper";
  cfg = config.programs.${program-name};
in
{
  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      cfg.package
    ];
    services.ratbagd.enable = true;
  };
}
