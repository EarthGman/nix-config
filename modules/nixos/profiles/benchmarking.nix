{ lib, config, ... }@args:
let
  desktop = if args ? desktop then args.desktop else null;
  hasDesktop = desktop != null;
  inherit (lib) mkDefault;
in
{
  options.profiles.benchmarking.enable = lib.mkEnableOption "enable benchmarking profile";
  config = lib.mkIf config.profiles.benchmarking.enable {
    programs = {
      phoronix.enable = mkDefault true;
      sysbench.enable = mkDefault true;
      kdiskmark.enable = mkDefault hasDesktop;
      glmark2.enable = mkDefault hasDesktop;
    };
  };
}
