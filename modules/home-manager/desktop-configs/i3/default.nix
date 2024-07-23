{ self, pkgs, wallpaper, lib, hostname, username, ... }:
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
      startup = lib.optionals (hostname == "cypher") [
        # position and scale monitors
        {
          command = "${self}/modules/home-manager/desktop-configs/i3/monitors.sh";
          always = false;
          notification = false;
        }
      ] ++ lib.optionals (username == "g") [
        # LH mouse
        {
          command = "${pkgs.xorg.xmodmap}/bin/xmodmap ${self}/modules/home-manager/desktop-configs/i3/.xmodmap";
          always = true;
          notification = false;
        }
      ] ++ [
        {
          command = "${self}/modules/home-manager/desktop-configs/i3/polybar/launch.sh";
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
    # picom = {
    #   enable = true;
    # };
    polybar = {
      enable = true;
      script = readFile ./polybar/launch.sh;
      extraConfig = readFile ./polybar/polybar.ini;
    };
  };
}
