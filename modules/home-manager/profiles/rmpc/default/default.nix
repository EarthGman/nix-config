{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (builtins) readFile;
  inherit (lib) mkEnableOption mkIf;
  cfg = config.profiles.rmpc.default;
in
{
  options.profiles.rmpc.default.enable = mkEnableOption "default rmpc profile";

  config = mkIf cfg.enable {
    home.packages = mkIf config.programs.rmpc.enable (with pkgs; [ nerd-fonts.meslo-lg ]);

    programs.rmpc.config = readFile ./config.ron;

    xdg.configFile."rmpc/themes/default.ron" =
      let
        cfg = config.programs.rmpc;
      in
      mkIf (cfg.enable && !cfg.imperativeConfig) {
        enable = true;
        text = readFile ./theme.ron;
      };
  };
}
