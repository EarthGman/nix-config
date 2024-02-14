{ pkgs, ... }:
{
  programs = {
    zsh = {
      enable = true;
      shellAliases = import ./shell-aliases.nix { inherit pkgs; };
    };
    direnv.enable = true;
    direnv.nix-direnv.enable = true;
  };
}
