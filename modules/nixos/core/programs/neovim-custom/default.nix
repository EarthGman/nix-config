{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.programs.neovim-custom;
in
{
  config = lib.mkIf cfg.enable {
    environment.variables.EDITOR = lib.mkIf cfg.defaultEditor (lib.mkForce "nvim");

    environment.systemPackages = [
      cfg.package
    ]
    ++ lib.optionals cfg.viAlias [
      (pkgs.symlinkJoin {
        name = "vi";
        paths = [ cfg.package ];

        postBuild = ''
          rm -f $out/bin/vi
          ln -s $out/bin/nvim $out/bin/vi
        '';
      })
    ]
    ++ lib.optionals cfg.vimAlias [
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
