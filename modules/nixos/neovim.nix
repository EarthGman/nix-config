{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    viAlias = true;
    package = pkgs.unstable.neovim-unwrapped;
  };
}
