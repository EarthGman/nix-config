{ inputs, lib, config, platform, ... }:
let
  inherit (lib) mkEnableOption mkIf mkOption types;
  cfg = config.programs.neovim-custom;
in
{
  options.programs.neovim-custom = {
    enable = mkEnableOption "enable my custom neovim";
    package = mkOption {
      description = "package for custom neovim";
      type = types.package;
      default = inputs.vim-config.packages.${platform}.default;
    };
    viAlias = mkEnableOption "enable vi alias for custom neovim";
    vimAlias = mkEnableOption "enable vim alias for custom neovim";
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];

    programs.zsh.shellAliases = {
      vi = mkIf (cfg.viAlias) "nvim";
      vim = mkIf (cfg.vimAlias) "nvim";
    };
  };
}
