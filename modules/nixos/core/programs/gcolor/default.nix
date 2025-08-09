{
  lib,
  config,
  ...
}:
let
  program-name = "gcolor";
  cfg = config.programs.${program-name};
in
{
  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      cfg.package
    ];
  };
}
