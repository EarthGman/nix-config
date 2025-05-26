{ pkgs, lib, config, ... }:
let
  inherit (builtins) readFile;
  inherit (lib) mkEnableOption mkIf;
  cfg = config.profiles.rmpc.default;
in
{
  options.profiles.rmpc.default.enable = mkEnableOption "default rmpc profile";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ nerd-fonts.meslo-lg ];

    programs.rmpc.config = readFile ./config.ron;

    xdg.configFile."rmpc/themes/default.ron" = {
      enable = true;
      text = readFile ./theme.ron;
    };
  };
}




