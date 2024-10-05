{ pkgs, lib, ... }:
{
  programs.neovim = {
    package = pkgs.neovim-unwrapped;
    enable = lib.mkDefault true;
    viAlias = true;
    vimAlias = true;
    configure = {
      customRC = "luafile ${./init.lua}";
      packages.myPlugins = with pkgs.vimPlugins; {
        start = [
          plenary-nvim
          telescope-nvim
          vim-nix
        ];
      };
    };
  };
}
