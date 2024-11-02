{ pkgs, lib, config, ... }:
{
  options.programs.video-trimmer.enable = lib.mkEnableOption "enable video-trimmer";
  config = lib.mkIf config.programs.video-trimmer.enable {
    home.packages = with pkgs; [
      video-trimmer
    ];
  };
}
