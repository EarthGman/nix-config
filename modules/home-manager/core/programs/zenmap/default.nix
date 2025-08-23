{
  lib,
  config,
  ...
}:
let
  program-name = "zenmap";
  cfg = config.programs.${program-name};
in
{
  config = lib.mkIf cfg.enable {
    programs.nmap.enable = true;
    home.packages = [
      cfg.package
    ];
  };
}
