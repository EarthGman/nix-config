{ pkgs, lib, config, ... }:
let
  inherit (lib) optionals mkIf;
  cfg = config.programs.neovim-custom;
in
{
  config = mkIf cfg.enable {
    home.packages = [ cfg.package ]
      ++ optionals cfg.viAlias
      [
        (
          pkgs.symlinkJoin
            {
              name = "vi";
              paths = [ cfg.package ];

              postBuild = ''
                rm -f $out/bin/vi
                ln -s $out/bin/nvim $out/bin/vi
              '';
            }
        )
      ]
      ++ optionals cfg.vimAlias
      [
        (
          pkgs.symlinkJoin
            {
              name = "vim";
              paths = [ cfg.package ];

              postBuild = ''
                rm -f $out/bin/vim
                ln -s $out/bin/nvim $out/bin/vim
              '';
            }
        )
      ];
  };
}
