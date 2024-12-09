{ config, lib, ... }:
let
  inherit (lib) mkDefault;
in
{
  modi = mkDefault "drun,window,run,ssh";
  icon-theme = mkDefault "Oranchelo";
  show-icons = mkDefault true;
  terminal = config.custom.terminal;
  drun-display-format = mkDefault "{icon} {name}";
  location = mkDefault 0;
  disable-history = mkDefault false;
  hide-scrollbar = mkDefault true;
  display-ssh = mkDefault "  SSH";
  display-drun = mkDefault "🏃  Drun ";
  display-run = mkDefault " 🏃  Run ";
  display-window = mkDefault " 🪟  Window";
  sidebar-mode = mkDefault true;
}
