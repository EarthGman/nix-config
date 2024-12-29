{ inputs, lib, config, platform, ... }:
let
  inherit (lib) mkOption mkEnableOption mkIf types;
  cfg = config.programs.ghostty;
in
{
  options.programs.ghostty = {
    enable = mkEnableOption "enable ghostty";
    package = mkOption {
      description = "ghostty package derivation";
      type = types.package;
      default = inputs.ghostty.packages.${platform}.default;
    };
  };
  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}
