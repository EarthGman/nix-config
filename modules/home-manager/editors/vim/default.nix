{ pkgs, config, lib, ... }:
{
  options.vim.enable = lib.mkEnableOption "enable vim";
  config = lib.mkIf config.vim.enable {
    programs.vim.enable = true;
  };
}
