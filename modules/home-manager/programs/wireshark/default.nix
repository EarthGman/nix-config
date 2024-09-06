{ pkgs, config, lib, ... }:
{
  options.custom.wireshark.enable = lib.mkEnableOption "wireshark";
  config = lib.mkIf config.custom.wireshark.enable {
    home.packages = with pkgs; [
      wireshark
    ];
  };
}
