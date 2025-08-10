{
  lib,
  config,
  ...
}:
let
  program-name = "ledger-live-desktop";
  cfg = config.programs.${program-name};
in
{
  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      cfg.package
    ];
  };
}
