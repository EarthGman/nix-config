{ lib, config, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.profiles.lazygit.default;
in
{
  options.profiles.lazygit.default.enable = mkEnableOption "default lazygit profile";
  config = mkIf cfg.enable {
    stylix.targets.lazygit.enable = true;
  };
}
