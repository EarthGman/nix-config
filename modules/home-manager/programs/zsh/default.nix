{ pkgs, config, lib, ... }:
let
  inherit (lib) getExe mkIf;
  cfg = config.programs.zsh;
in
{
  programs.zsh = mkIf cfg.enable {
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autocd = true;
    shellAliases = {
      l = "${getExe pkgs.eza} -al --icons";
      ls = "${getExe pkgs.eza} --icons";
      lg = "${getExe pkgs.lazygit}";
      man = "${getExe pkgs.bat-extras.batman}";
    };
    initExtra = ''
      setopt interactivecomments
      compdef batman=man
      export EDITOR=${config.custom.editor}
      export PATH=$(realpath ~/bin):$PATH
    '';
  };
}
    
