{ pkgs, lib, config, ... }:
let
  inherit (lib) mkDefault mkEnableOption optionalString mkIf;
  cfg = config.programs;
in
{
  options.profiles.zsh.default.enable = mkEnableOption "zsh profie for nixos";
  config = mkIf config.profiles.zsh.default.enable {
    programs.zsh = {
      enable = true;
      enableCompletion = mkDefault true;
      syntaxHighlighting.enable = mkDefault true;
      autosuggestions.enable = mkDefault true;
      shellAliases = import ../../../shared/shell-aliases.nix { inherit pkgs lib config; };

      promptInit = ''
        setopt autocd
      '' + optionalString (cfg.yazi.enable) ''
         function y() {
         local tmp="$(mktemp -t "yazi-cwd.XXXXX")"
         yazi "$@" --cwd-file="$tmp"
         if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
           builtin cd -- "$cwd"
         fi
         rm -f -- "$tmp"
        }
      '';
    };
  };
}
