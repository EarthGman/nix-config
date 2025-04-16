{ pkgs, lib, config, ... }:
let
  inherit (lib) mkIf mkDefault mkEnableOption;
  cfg = config.modules.tmux;
in
{
  options.modules.tmux.enable = mkEnableOption "enable tmux configuration";

  config = mkIf (cfg.enable) {
    programs.tmux = {
      enable = true;
      shortcut = mkDefault "space";
      keyMode = mkDefault "vi";
      clock24 = mkDefault true; # military time is better
      baseIndex = mkDefault 1; # lua has corrupted me
      plugins = with pkgs.tmuxPlugins; [
        catppuccin
      ];
      extraConfig = ''
        bind-key h select-pane -L
        bind-key j select-pane -D
        bind-key k select-pane -U
        bind-key l select-pane -R

        unbind r
        bind r source-file /etc/tmux.conf
        set-option -g status-position top
      '';
    };
  };
}
