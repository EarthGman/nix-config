{
  pkgs,
  config,
  lib,
  ...
}:
{
  options.gman.zsh.enable = lib.mkEnableOption "gman's zsh configuration";
  config = lib.mkIf config.gman.zsh.enable {
    programs.zsh = {
      enable = true;
      autosuggestion.enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      autocd = true;
      shellAliases = import ../../../mixins/shell-aliases.nix { inherit pkgs lib config; } // {
        hms = "home-manager switch";
      };
      initContent = ''
        setopt interactivecomments
        compdef batman=man
      ''
      + lib.optionalString (config ? meta.editor && config.meta.editor != "") ''
        export EDITOR=${config.meta.editor}
      '';
    };
  };
}
