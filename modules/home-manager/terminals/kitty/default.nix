{ pkgs, lib, config, ... }:
{
  programs.kitty = {
    enable = true;
    font = {
      package = lib.mkForce pkgs.nerdfonts;
      name = lib.mkForce "DejaVuSansM Nerd Font";
      size = lib.mkForce 14.0;
    };
    extraConfig = ''
      background_opacity 0.87
      initial_window_width 640
      initial_window_height 400

      sync_to_monitor yes
    '';
  };
}
