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
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}
