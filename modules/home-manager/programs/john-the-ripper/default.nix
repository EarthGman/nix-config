{ pkgs, lib, config, ... }:
{
  options.programs.john-the-ripper.enable = lib.mkEnableOption "enable john-the-ripper a password cracker";
  config = lib.mkIf config.programs.john-the-ripper.enable {
    home.packages = [ pkgs.john ];
  };
}
