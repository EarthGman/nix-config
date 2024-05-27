{ pkgs, editor, ... }:
{
  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      autosuggestion.enable = true;
      shellAliases = import ./shell-aliases.nix;
      initExtra = ''
        eval "$(${pkgs.zoxide}/bin/zoxide init --cmd j zsh)"
        export PATH=$(realpath ~/bin):$PATH
        export EDITOR=${editor}
      '';
    };
  };
}
