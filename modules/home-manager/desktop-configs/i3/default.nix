{ self, outputs, pkgs, config, lib, wallpaper, hostname, username, ... }:
let
  inherit (builtins) readFile;
  wp = outputs.wallpapers.${wallpaper};
in
{
  home.packages = with pkgs; [
    feh
    networkmanager_dmenu
    pavucontrol
    pamixer
    flameshot
    maim
    xclip
    polybar
    gnome.gnome-system-monitor
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
          command = ''
            xrandr --output DisplayPort-2 --auto --right-of HDMI-A-0 \
                   --output DisplayPort-2 --mode 2560x1440 \
                   --output HDMI-A-0 --mode 1920x1080 --rate 74.97 \
            && ${pkgs.feh}/bin/feh --bg-scale ${wp}
          '';
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
          command = "${pkgs.picom}/bin/picom --config ~/.config/picom/picom.conf";
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
  xdg.configFile = {
    "picom/picom.conf".text = ''
      vsync = true
    '';
    "polybar/config.ini".source = ./polybar/config.ini;
    "flameshot/flameshot.ini".text = lib.generators.toINI { } {
      General = {
        "contrastOpacity" = 188;
        "copyOnDoubleClick" = true;
        "drawColor" = "#fff600";
        "drawThickness" = 26;
        "saveAfterCopy" = true;
        "saveAsFileExtension" = "png";
        "savePath" = "${config.home.homeDirectory}/Pictures/Screenshots";
        "savePathFixed" = true;
        "showHelp" = true;
      };
    };
  };
}
