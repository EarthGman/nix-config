{ inputs, lib, config, platform, ... }:
let
  inherit (lib) mkOption mkEnableOption mkIf types mkForce;
  cfg = config.programs.neovim-custom;
in
{
  options.programs.neovim-custom = {
    enable = mkEnableOption "my custom neovim";
    package = mkOption {
      description = "package for custom neovim";
      type = types.package;
      default = inputs.vim-config.packages.${platform}.default;
    };
    defaultEditor = mkEnableOption "nvim as default $EDITOR";
    viAlias = mkEnableOption "enable vi alias";
    vimAlias = mkEnableOption "enable vim alias";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];

    environment.variables.EDITOR = mkIf cfg.defaultEditor (mkForce "nvim");
    # ah hackfixes
    programs.zsh.shellAliases = {
      vi = mkIf (cfg.viAlias) "nvim";
      vim = mkIf (cfg.vimAlias) "nvim";
    };
  };
}
