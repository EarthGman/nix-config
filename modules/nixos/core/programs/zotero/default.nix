{
  lib,
  config,
  ...
}:
let
  program-name = "zotero";
  cfg = config.programs.${program-name};
in
{
  config = lib.mKIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
