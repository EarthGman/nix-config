{ pkgs, config, lib, ... }:
{
  options.programs.wireshark.enable = lib.mkEnableOption "wireshark";
  config = lib.mkIf config.programs.wireshark.enable {
    home.packages = with pkgs; [
      wireshark
    ];
  };
}
