{
  lib,
  config,
  ...
}:
let
  program-name = "john";
  cfg = config.programs.${program-name};
in
{
  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      cfg.package
    ];
  };
}
