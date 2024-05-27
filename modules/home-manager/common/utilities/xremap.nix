{ inputs, platform, pkgs, config, lib, ... }:
{
  options.xremap.enable = lib.mkEnableOption "enable xremap";
  config = lib.mkIf config.xremap.enable {
    home.packages = [
      inputs.xremap.packages.${platform}.default
    ];
  };
}
