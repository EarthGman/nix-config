{ pkgs, lib, config, ... }:
{
  options.modules.benchmarking.enable = lib.mkEnableOption "enable benchmarking module";
  config = lib.mkIf config.modules.benchmarking.enable {
    environment.systemPackages = with pkgs; [
      phoronix-test-suite
      kdiskmark
    ];
  };
}
