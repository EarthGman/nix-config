# default fzf config
{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib)
    getExe
    mkEnableOption
    mkIf
    ;
  cfg = config.profiles.fzf.default;
in
{
  options.profiles.fzf.default.enable = mkEnableOption "default fzf profile";
  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.fzf-edit ]; # customized script which opens the selected file in $EDITOR
    programs.fzf = {
      enable = true;
      keybindings = true;
    };
    environment.variables = {
      FZF_DEFAULT_COMMAND = "${getExe pkgs.silver-searcher} --hidden --ignore .git -l -g ''";
      FZF_DEFAULT_OPTS = "--preview 'bat --style=numbers --color=always {}'";
      FZF_TMUX = "1";
    };
  };
}
