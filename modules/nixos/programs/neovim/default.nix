{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (lib) mkIf mkForce optionals;
  cfg = config.programs.neovim-custom;
in
{
  config = mkIf cfg.enable {
    environment.variables.EDITOR = mkIf cfg.defaultEditor (mkForce "nvim");

    environment.systemPackages =
      [ cfg.package ]
      ++ optionals cfg.viAlias [
        (pkgs.symlinkJoin {
          name = "vi";
          paths = [ cfg.package ];

          postBuild = ''
            rm -f $out/bin/vi
            ln -s $out/bin/nvim $out/bin/vi
          '';
        })
      ]
      ++ optionals cfg.vimAlias [
        (pkgs.symlinkJoin {
          name = "vim";
          paths = [ cfg.package ];

          postBuild = ''
            rm -f $out/bin/vim
            ln -s $out/bin/nvim $out/bin/vim
          '';
        })
      ];
  };
}
