{ lib, config, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.neovim-custom;
in
{
  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];

    programs.zsh.shellAliases = {
      vi = mkIf (cfg.viAlias) "nvim";
      vim = mkIf (cfg.vimAlias) "nvim";
    };
  };
}
