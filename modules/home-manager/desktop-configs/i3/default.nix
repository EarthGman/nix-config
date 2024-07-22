{ self, pkgs, wallpaper, lib, ... }:
let
  inherit (builtins) readFile;
  wp = self + /modules/home-manager/stylix/wallpapers/${wallpaper};
in
{
  home.packages = with pkgs; [
    feh
  ];
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      bars = lib.mkForce [ ];
      modifier = "Mod4";
      floating.modifier = "Mod4";
      terminal = "kitty";
      workspaceAutoBackAndForth = true;
      keybindings = import ./keybinds.nix;
      startup = [
        {
          command = "systemctl --user restart polybar";
          always = true;
          notification = false;
        }
        {
          command = "picom";
          always = false;
          notification = false;
        }
        {
          command = "${pkgs.feh}/bin/feh --bg-scale ${wp}";
          always = true;
          notification = false;
        }
      ];
    };
  };
  programs = {
    rofi = {
      enable = true;
      extraConfig = import ./rofi/config.nix;
    };
  };
  services = {
    picom = {
      enable = true;
    };
    polybar = {
      enable = true;
      script = readFile ./polybar/launch.sh;
      extraConfig = readFile ./polybar/polybar.ini;
    };
  };
}
