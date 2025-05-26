{ lib, config, ... }@args:
let
  desktop = if args ? desktop then args.desktop else null;
  hasDesktop = desktop != null;
  inherit (lib) mkDefault;
in
{
  options.modules.benchmarking.enable = lib.mkEnableOption "enable benchmarking module";
  config = lib.mkIf config.modules.benchmarking.enable {
    programs = {
      phoronix.enable = mkDefault true;
      sysbench.enable = mkDefault true;
      kdiskmark.enable = mkDefault hasDesktop;
      glmark2.enable = mkDefault hasDesktop;
    };
  };
}
