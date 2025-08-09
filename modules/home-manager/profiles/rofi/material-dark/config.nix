{ config, lib, ... }:
{
  modi = lib.mkDefault "drun,run,ssh";
  icon-theme = lib.mkDefault "Oranchelo";
  show-icons = lib.mkDefault true;
  terminal = config.meta.terminal;
  location = lib.mkDefault 0;
  disable-history = lib.mkDefault false;
  hide-scrollbar = lib.mkDefault true;
  display-ssh = lib.mkDefault "  SSH";
  display-drun = lib.mkDefault "🏃  Drun ";
  display-run = lib.mkDefault " 🏃  Run ";
  display-window = lib.mkDefault "   Window";
  sidebar-mode = lib.mkDefault true;
}
