# default fzf config
{ lib, config, pkgs, ... }:
let
  inherit (lib) getExe mkEnableOption mkDefault mkIf;
in
{
  options.modules.fzf.enable = mkEnableOption "fzf config";
  config = mkIf config.modules.fzf.enable {
    environment.systemPackages = [ pkgs.fzf-edit ];
    programs.fzf = {
      enable = true;
      keybindings = true;
    };
    environment.variables = {
      FZF_DEFAULT_COMMAND = mkDefault "${getExe pkgs.silver-searcher} --hidden --ignore .git -l -g ''";
      FZF_DEFAULT_OPTS = mkDefault "--preview 'bat --style=numbers --color=always {}'";
      FZF_TMUX = mkDefault "1";
    };
  };
}
