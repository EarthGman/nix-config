{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.gman.tmux;
in
{
  options.gman.tmux = {
    enable = lib.mkEnableOption "gman's tmux configuration";
    config = {
      hostIcon = lib.mkOption {
        description = "icon to use for the hostname tab";
        type = lib.types.str;
        default = " ";
      };
    };
  };

  config = lib.mkIf config.gman.tmux.enable {
    programs.tmux = {
      shortcut = lib.mkDefault "space";
      clock24 = lib.mkDefault true;
      baseIndex = 1;
      # plugins = with pkgs.tmuxPlugins; [
      #   vim-tmux-navigator
      # ];
      extraConfig = ''
        set -g mouse on
        set -g allow-passthrough on
        set-option -g status-position top

        set -g @dracula-show-powerline true
        set -g @dracula-show-left-icon "${cfg.config.hostIcon}#h"
        set -g @dracula-plugins "battery" 
        set -g @dracula-no-battery-label 󱉝
        set -g @dracula-battery-label " "
        set -g @dracula-show-battery-status true

        run-shell ${pkgs.tmuxPlugins.dracula}/share/tmux-plugins/dracula/dracula.tmux

        # Smart pane switching with awareness of Vim splits.
        # See: https://github.com/christoomey/vim-tmux-navigator
        is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
            | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?\.?(view|l?n?vim?x?|${lib.getExe pkgs.fzf})(diff)?(-wrapped)?$'"
        bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
        bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
        bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
        bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l'  'select-pane -R'
        tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'
        if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
            "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\'  'select-pane -l'"
        if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
            "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"

        bind-key -T copy-mode-vi 'C-h' select-pane -L
        bind-key -T copy-mode-vi 'C-j' select-pane -D
        bind-key -T copy-mode-vi 'C-k' select-pane -U
        bind-key -T copy-mode-vi 'C-l' select-pane -R
        bind-key -T copy-mode-vi 'C-\' select-pane -l
      '';
    };
  };
}
