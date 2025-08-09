{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.gman.kitty;
in
{
  options.gman.kitty.enable = lib.mkEnableOption "gman's kitty configuration";
  config = lib.mkIf cfg.enable {
    # ensure font is installed
    home.packages = [
      pkgs.nerd-fonts.meslo-lg
    ];

    stylix.targets.kitty.enable = true;

    programs.kitty = {
      enable = true;
      settings = {
        font_family = "MesloLGS Nerd Font";
        update_check_interval = 0;
        tab_bar_style = "powerline";
        tab_powerline_style = "slanted";
        confirm_os_window_close = 0;
        copy_on_select = "clipboard";
        enable_audio_bell = "no";
        hide_window_decorations = "no";
        placement_strategy = "center";
        scrollback_lines = 20000;
        initial_window_width = 640;
        initial_window_height = 400;
        sync_to_monitor = "yes";
      };
    };
  };
}
