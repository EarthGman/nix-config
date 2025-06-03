{ pkgs, ... }:
{
  custom.terminal = "wezterm";
  home.packages = [ pkgs.wezterm ];

  programs.waybar.bottomBar.settings."custom/os_button".format = " ";
  programs.fastfetch.image = "arch";
}
