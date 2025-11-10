{
  lib,
  config,
  ...
}:
let
  program-name = "nmap";
  cfg = config.programs.${program-name};
in
{
  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      cfg.package
    ];
  };
}
