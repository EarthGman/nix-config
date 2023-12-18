{ pkgs, ... }:
{
  programs = {
    starship.enable = true;
    zsh = {
      enable = true;
      enableBashCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting = {
        enable = true;
        highlighters = [ "main" "brackets" ];
      };
      shellAliases = import ./shell-aliases.nix { inherit pkgs; };
      interactiveShellInit = ''
        eval "$(${pkgs.zoxide}/bin/zoxide init --cmd j zsh)"
        export PATH=$(realpath ~/bin):$PATH
      '';
    };
  };
}
