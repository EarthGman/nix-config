{ pkgs, lib, config, ... }:
# default nvim config applied to all users and machines accross the configuration.
# extra configuration such as LSPs, plugins, and styles are configured with home-manager
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
            vim-nix # for editing nix files for installers
          ];
        };
      };
    };
  };
}
