{ terminal, lib, ... }:
{
  imports =
    lib.optionals (terminal == "alacritty") [ ./alacritty ] ++
    lib.optionals (terminal == "kitty") [ ./kitty ] ++
    lib.optionals (terminal == "wezterm") [ ./wezterm ];
}
