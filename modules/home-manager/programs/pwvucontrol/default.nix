{ pkgs, config, lib, ... }:
let
  inherit (lib) mkIf mkEnableOption mkOption types;
  cfg = config.programs.pwvucontrol;
in
{
  options.programs.pwvucontrol = {
    enable = mkEnableOption "enable pwvucontrol, a gui for audio control via pipewire";

    package = mkOption {
      description = "package for pwvucontrol";
      type = types.package;
      default = pkgs.pwvucontrol;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
