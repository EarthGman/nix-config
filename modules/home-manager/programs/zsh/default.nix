{ pkgs, config, lib, hostName, ... }:
let
  inherit (lib) getExe mkIf mkDefault;
  cfg = config.programs.zsh;
in
{
  programs.zsh = mkIf cfg.enable {
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autocd = true;
    shellAliases = {
      l = "${getExe pkgs.eza} -al --icons";
      ls = "${getExe pkgs.eza} --icons";
      lg = "${getExe pkgs.lazygit}";
      edit-config = "cd ~/src/nix-config && $EDITOR .";
      edit-preferences = "cd ~/src/nix-config/hosts/${hostName}/users/${config.home.username} && $EDITOR preferences.nix";
      man = "${getExe pkgs.bat-extras.batman}";
    };
    initExtra = ''
      setopt interactivecomments
      compdef batman=man
      export EDITOR=${config.custom.editor}
      export PATH=$(realpath ~/bin):$PATH
    '';
  };
}
    
