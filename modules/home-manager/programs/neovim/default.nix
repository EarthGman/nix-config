{ pkgs, lib, config, ... }:
let
  cfg = config.programs.neovim;
  inherit (lib) mkIf mkDefault;
in
{
  programs.neovim = {
    package = pkgs.neovim-unwrapped;
    vimAlias = true;
    viAlias = true;
    vimdiffAlias = true;

    plugins = with pkgs.vimPlugins; [
      telescope-nvim
      plenary-nvim

      nvim-treesitter
      nvim-treesitter.withAllGrammars
		  
			gruvbox
    ];

    # extraPackages = with pkgs; [ ]
    # extraLuaConfig = builtins.readFile ./init.lua
  };

  stylix.targets.neovim.enable = mkIf cfg.enable (mkDefault false);
  # xdg.configFile."nvim/lua" = mkIf cfg.enable {
  #   source = ./lua;
}
