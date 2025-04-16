{ pkgs, lib, ... }:
let
  inherit (lib) mkDefault;
in
{
  programs.tmux = {
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
}
