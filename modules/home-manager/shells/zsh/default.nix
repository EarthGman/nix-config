{ pkgs, ... }:
{
  programs = { 
    zsh = {
      enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      autosuggestion.enable = true;
      shellAliases = import ./shell-aliases.nix;
      # maps j as the command for zoxide jumping
      initExtra = ''
        eval "$(${pkgs.zoxide}/bin/zoxide init --cmd j zsh)"
        export PATH=$(realpath ~/bin):$PATH
      '';
    };
  };
}