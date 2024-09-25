{ self, wallpapers, ... }:
let
  template = self + /templates/home-manager/g.nix;
  theme = self + /modules/home-manager/desktop-configs/themes/ashes.nix;
in
{
  imports = [
    theme
    template
  ];

  stylix.image = builtins.fetchurl wallpapers.scarlet-tree-dark;
  stylix.fonts.sizes = {
    terminal = 12;
  };

  services.polybar.settings = {
    "bar/top" = {
      height = "16pt";
      font-0 = "MesloLGS Nerd Font Mono:size=12;4";
    };
    "bar/bottom" = {
      height = "16pt";
      font-0 = "MesloLGS Nerd Font Mono:size=12;4";
    };
  };

  #modules
  programs = {
    google-chrome.enable = true;
    firefox.theme.name = "";
  };
}
