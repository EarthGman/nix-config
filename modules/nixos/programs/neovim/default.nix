{ lib, config, ... }:
let
  inherit (lib) mkIf mkForce;
  cfg = config.programs.neovim-custom;
in
{
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
