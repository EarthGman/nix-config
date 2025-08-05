{
  lib,
  config,
  ...
}:
let
  inherit (lib) mkIf;
  cfg = config.programs.gnome-text-editor;
in
{
  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}
