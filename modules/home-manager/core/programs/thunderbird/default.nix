{
  lib,
  config,
  ...
}:
let
  program-name = "thunderbird";
  cfg = config.programs.${program-name};
in
{
  options.programs.thunderbird.imperativeConfig = lib.mkEnableOption "imperative configuration for thunderbird";

  config = lib.mkIf cfg.enable {
    programs.thunderbird.profiles = lib.mkIf (cfg.imperativeConfig) (lib.mkForce { });
  };
}
