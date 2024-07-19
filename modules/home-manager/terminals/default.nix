{ lib, ... }:
{
  imports = [
    ./alacritty
    ./wezterm
    ./kitty
  ];
  kitty.enable = lib.mkDefault true;
}
