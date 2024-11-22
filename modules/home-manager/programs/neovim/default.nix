{ pkgs, lib, config, ... }:
let
  cfg = config.programs.neovim;
  inherit (lib) mkIf mkDefault;
in
{
  programs.neovim = {
    package = pkgs.neovim-unwrapped;
    # provide aliases just in case nvim isn't recognized by something
    vimAlias = true;
    viAlias = true;
    vimdiffAlias = true;

    plugins = with pkgs.vimPlugins; [
      telescope-nvim # file search tui
      plenary-nvim # popular dependency needed by most vim plugins
      nvim-treesitter # treesitter configuration
      nvim-treesitter.withAllGrammars # TODO: add only needed languages (will save ~200Mb of disk)
      lspkind-nvim # plugin to provide icons for various lsps 
      nvim-lspconfig # allow configuration of an lsp using lua
      gruvbox # pretty good theme
    ];

    extraPackages = with pkgs; [
      # packages accessible to vim but not placed on the main shell path
      nil # nix language server
      lua-language-server

      nixpkgs-fmt # nix formatter
      stylua # opionated Lua code formatter
    ];
    # TODO: uncommenting will make vim config truly declarative
    extraLuaConfig = builtins.readFile ./init.lua;
  };

  # by default dont let stylix style vim since it is kind of jank
  stylix.targets.neovim.enable = mkIf cfg.enable (mkDefault false);

  # TODO: uncomment alongside extraLuaConfig for truly declarative configuration
  xdg.configFile."nvim/lua" = mkIf cfg.enable {
     source = ./lua;
  };
}
