{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.profiles.kitty.default;
in
{
  options.profiles.kitty.default.enable = mkEnableOption "default kitty profile";
  config = mkIf cfg.enable {
    # ensure font is installed
    home.packages = mkIf config.programs.kitty.enable [
      pkgs.nerd-fonts.meslo-lg
    ];

    stylix.targets.kitty.enable = true;

    programs.kitty = {
      settings = {
        # kitty is so freaking sensitive with fonts so just force this one since it works well
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
        background_opacity = lib.mkForce "0.87";
        initial_window_width = 640;
        initial_window_height = 400;
        sync_to_monitor = "yes";
      };
    };
  };
}
