{ inputs, platform, ... }:
{
  programs.hyprland = {
    # package = inputs.hyprland.packages.${platform}.hyprland;
    enable = true;
  };
}
