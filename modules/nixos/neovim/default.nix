{ pkgs, lib, config, ... }:
let
  cfg = config.modules.neovim;
in
{
  options.modules.neovim.enable = lib.mkEnableOption "enable neovim";
  config = lib.mkIf cfg.enable {
    programs.neovim = {
      package = pkgs.neovim-unwrapped;
      enable = true;
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
  };
}
