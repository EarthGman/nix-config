{ inputs, lib, config, platform, ... }:
let
  inherit (lib) mkOption mkEnableOption mkIf types mkDefault;
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
    viAlias = mkEnableOption "enable vi alias";
    vimAlias = mkEnableOption "enable vim alias";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
    programs.neovim-custom = {
      viAlias = mkDefault true;
      vimAlias = mkDefault true;
    };

    # ah hackfixes
    programs.zsh.shellAliases = {
      vi = mkIf (cfg.viAlias) "nvim";
      vim = mkIf (cfg.vimAlias) "nvim";
    };
  };
}
