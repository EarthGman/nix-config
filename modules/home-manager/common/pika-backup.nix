{ pkgs, config, lib, ... }:
{
  options.pika-backup.enable = lib.mkEnableOption "enable pika-backup";
  config = lib.mkIf config.pika-backup.enable {
    home.packages = with pkgs; [
      pika-backup
    ];
  };
}
