{ lib, config, ... }:
{
  options.custom.kitty.enable = lib.mkEnableOption "kitty config";
  config = lib.mkIf config.custom.kitty.enable {
    programs.kitty = {
      enable = true;
      settings = {
        update_check_interval = 0;
        tab_bar_style = "powerline";
        tab_powerline_style = "slanted";
        confirm_os_window_close = 0;
        copy_on_select = "clipboard";
        enable_audio_bell = "no";
        hide_window_decorations = "no";
        placement_strategy = "center";
        scrollback_lines = 20000;
        background_opacity = lib.mkForce "0.87";
        initial_window_width = 640;
        initial_window_height = 400;
        sync_to_monitor = "yes";
      };
    };
  };
}
