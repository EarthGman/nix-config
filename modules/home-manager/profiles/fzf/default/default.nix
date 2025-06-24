{ pkgs, lib, config, ... }:
let
  inherit (lib) mkIf mkEnableOption getExe;
  cfg = config.profiles.fzf.default;
in
{
  options.profiles.fzf.default.enable = mkEnableOption "default fzf profile";
  config = mkIf cfg.enable {
    home.packages = mkIf config.programs.fzf.enable ([ pkgs.silver-searcher ]);
    stylix.targets.fzf.enable = true;
    programs.fzf = {
      tmux.enableShellIntegration = true;
      defaultCommand = "${getExe pkgs.silver-searcher} --hidden --ignore .git -l -g ''";
      defaultOptions = [
        "--preview 'bat --style=numbers --color=always {}'"
      ];
    };
  };
}
