{ pkgs, config, lib, ... }:
{
  options.neovim.enable = lib.mkEnableOption "enable neovim";
  config = lib.mkIf config.neovim.enable {
    programs.neovim.enable = true;
  };
}
