{ pkgs, ... }:
{
  programs = {
    zsh.enable = true;
    direnv.enable = true;
    direnv.nix-direnv.enable = true;
  };
}
