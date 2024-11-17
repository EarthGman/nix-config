{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;

    vimAlias = true;
    viAlias = true;

    plugins = with pkgs.vimPlugins; [
      alpha-nvim
      bufferline-nvim
      cmp-buffer
      cmp-nvim-lsp
      cmp-path
      cmp-spell
      cmp-treesitter
      cmp-vsnip
      fidget-nvim
      gitsigns-nvim
      lsp-format-nvim
      lspkind-nvim
      lualine-nvim
      none-ls-nvim
      nvim-autopairs
      nvim-cmp
      nvim-colorizer-lua
      nvim-dap
      nvim-dap-ui
      nvim-lspconfig
      nvim-tree-lua
      plenary-nvim
      rainbow-delimiters-nvim
      telescope-fzy-native-nvim
      telescope-nvim
      which-key-nvim
    ];

    extraPackages = with pkgs; [
      nil
      gcc
      ripgrep
      fd
      nixpkgs-fmt
    ];
    extraLuaConfig = ''
      _G.map = vim.keymap.set
      _G.P = vim.print

      require("core.util")
      require("core.options")
      require("core.keymaps")
      require("ui.theme")
      require("lsp")
      require("plugs")
    '';
  };
  xdg.configFile."nvim/lua" = {
    source = ./lua;
  };
}
