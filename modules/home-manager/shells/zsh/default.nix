{ self, pkgs, config, username, hostname, ... }:
{
  programs = {
    starship = {
      enable = true;
      enableZshIntegration = true;
    };
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    zsh = {
      enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      autosuggestion.enable = true;
      shellAliases = import ./shell-aliases.nix { inherit pkgs username hostname; };
      initExtra = ''
        eval "$(${pkgs.zoxide}/bin/zoxide init --cmd j zsh)"
        export PATH=$(realpath ~/bin):$PATH
        export EDITOR=${config.preferredEditor}
      '';
    };
  };
}
