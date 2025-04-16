{ lib, config, desktop, ... }:
let
  inherit (lib) mkDefault;
in
{
  options.modules.benchmarking.enable = lib.mkEnableOption "enable benchmarking module";
  config = lib.mkIf config.modules.benchmarking.enable {
    programs = {
      phoronix.enable = mkDefault true;
      kdiskmark.enable = mkDefault desktop != null;
    };
  };
}
