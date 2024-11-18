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

    plugins = with pkgs.vimPlugins; [
      plenary-nvim
      telescope-nvim
      vim-nix
      nvim-lspconfig
    ];

    extraPackages = with pkgs; [
      nil
      ripgrep
      fd
      nixpkgs-fmt
    ];

    extraLuaConfig = builtins.readFile ./init.lua;
  };

  stylix.targets.neovim.enable = mkIf cfg.enable (mkDefault false);
  xdg.configFile."nvim/lua" = mkIf cfg.enable {
    source = ./lua;
  };
}
