{ pkgs, ... }:
{
  programs.hyprland.enable = true;

  environment.systemPackages = with pkgs; [
    dunst # notification deamon for hyprland
    libnotify # needed for dunst to work
    waybar # bar for hyprland
    swww # wallpaper
    rofi-wayland
  ];
}
