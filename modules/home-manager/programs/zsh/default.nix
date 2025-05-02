{ pkgs, config, lib, ... }:
let
  inherit (lib) getExe mkIf;
  cfg = config.programs;
in
{
  programs.zsh = {
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autocd = true;
    shellAliases =
      let
        has-git = cfg.git.enable;
      in
      {
        l = if cfg.eza.enable then "${getExe cfg.eza.package} -al --icons" else "ls -al";
        ls = mkIf cfg.eza.enable "${getExe cfg.eza.package} --icons";
        lg = mkIf has-git "${getExe cfg.lazygit.package}";
        g = mkIf has-git "${getExe cfg.git.package}";
        ga = mkIf has-git "${cfg.git.package} add .";
        gco = mkIf has-git "${cfg.git.package} checkout";
        hms = "home-manager switch";
        cat = mkIf cfg.bat.enable "${getExe cfg.bat.package}";
        t = "${getExe pkgs.tree}";
      };
    initContent = ''
      setopt interactivecomments
      compdef batman=man
      export EDITOR=${config.custom.editor}
    '';
  };
}
    
