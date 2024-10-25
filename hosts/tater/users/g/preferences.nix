{ self, lib, ... }:
let
  profile = self + /profiles/home-manager/g.nix;
  theme = self + /profiles/home-manager/desktop-themes/faraway.nix;
in
{
  imports = [
    theme
    profile
  ];
  stylix.fonts.sizes = {
    terminal = lib.mkForce 12;
  };

  services.polybar.settings = {
    "bar/bottom" = {
      height = "16pt";
      font-0 = "MesloLGS Nerd Font Mono:size=12;4";
      modules-left = "wlan cpu memory";
    };
  };

  #respondus BS
  programs = {
    google-chrome.enable = true;
  };
}
