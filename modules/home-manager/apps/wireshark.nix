{ pkgs, config, lib, ... }:
{
  options.wireshark.enable = lib.mkEnableOption "wireshark";
  config = lib.mkIf config.wireshark.enable {
    home.packages = with pkgs; [
      wireshark
    ];
  };
}
