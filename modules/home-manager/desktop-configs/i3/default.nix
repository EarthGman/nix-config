{ self, pkgs, config, lib, wallpaper, hostname, username, ... }:
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
      window = {
        hideEdgeBorders = "both";
      };
      startup = lib.optionals (hostname == "cypher") [
        # position and scale monitors
        {
          command = "${self}/scripts/monitors.sh";
          always = false;
          notification = false;
        }
      ] ++ lib.optionals (username == "g") [
        # LH mouse
        {
          command = "${pkgs.xorg.xmodmap}/bin/xmodmap ${self}/scripts/.xmodmap";
          always = true;
          notification = false;
        }
      ] ++ [
        {
          command = "${self}/scripts/polybar.sh";
          always = true;
          notification = false;
        }
        {
          command = "picom";
          always = false;
          notification = false;
        }
        {
          command = "sleep 0.4 && ${pkgs.feh}/bin/feh --bg-scale ${wp}";
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
      vsync = true;
      enable = true;
    };
    polybar = {
      enable = true;
      script = readFile (self + /scripts/polybar.sh);
      extraConfig = readFile ./polybar/polybar.ini;
    };
  };
}
