{
  pkgs,
  config,
  lib,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption optionalString;
in
{
  options.profiles.zsh.default.enable = mkEnableOption "default zsh profile";
  config = mkIf config.profiles.zsh.default.enable {
    programs.zsh = {
      autosuggestion.enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      autocd = true;
      shellAliases = import ../../../../shared/shell-aliases.nix { inherit pkgs lib config; } // {
        hms = "home-manager switch";
      };
      initContent =
        ''
          setopt interactivecomments
          compdef batman=man
        ''
        + optionalString (config ? custom.editor) ''
          export EDITOR=${config.custom.editor}
        '';
    };
  };
}
