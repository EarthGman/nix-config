{ pkgs, config, lib, ... }:
let
  inherit (lib) getExe mkIf mkEnableOption optionalString;
  cfg = config.programs;
in
{
  options.profiles.zsh.enable = mkEnableOption "zsh profile";
  config = mkIf config.profiles.zsh.enable {
    programs.zsh = {
      enable = true;
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
          ga = mkIf has-git "${getExe cfg.git.package} add .";
          gco = mkIf has-git "${getExe cfg.git.package} checkout";
          hms = "home-manager switch";
          cat = mkIf cfg.bat.enable "${getExe cfg.bat.package}";
          t = "${getExe pkgs.tree}";
        };
      initContent = ''
        setopt interactivecomments
        compdef batman=man
      '' + optionalString (config ? custom.editor) ''
        export EDITOR=${config.custom.editor}
      '';
    };
  };
}
    
