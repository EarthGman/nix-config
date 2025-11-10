{
  pkgs,
  lib,
  config,
  ...
}:
{
  bars = lib.mkForce [ ];
  modifier = lib.mkDefault "Mod4"; # window
  floating = {
    modifier = lib.mkDefault "Mod4"; # window
    titlebar = lib.mkDefault false;
  };
  menu = "rofi";
  terminal = config.custom.terminal;
  workspaceAutoBackAndForth = lib.mkDefault true;
  keybindings = import ./keybinds.nix {
    inherit
      pkgs
      config
      lib
      ;
  };
  modes = {
    resize = {
      Up = "resize grow height 10px";
      Down = "resize shrink height 10 px";
      Escape = "mode default";
      Left = "resize grow width 10 px";
      Return = "mode default";
      Right = "resize shrink width 10 px";
      h = "resize grow width 10px";
      j = "resize shrink height 10px";
      k = "resize grow height 10px";
      l = "resize shrink width 10px";
    };
  };
  gaps = {
    inner = lib.mkDefault 2;
    outer = lib.mkDefault 2;
  };
  window = {
    hideEdgeBorders = lib.mkDefault "none";
    titlebar = lib.mkDefault false;
  };

  # use kanshi for display configuration as it also ports to hyprland seamlessly
  output."*" = lib.mkForce { };
  startup = [
    {
      command = "uwsm finalize";
    }
    {
      # sway starts at workspace 10 for some reason
      command = "swaymsg workspace 1";
    }
    {
      command = "systemctl --user restart waybar";
      always = true;
    }
    {
      command = "systemctl --user restart swww";
      always = true;
    }
    {
      command = "systemctl --user restart swayidle";
      always = true;
    }
  ]
  ++ lib.optionals (config.services.kanshi.enable) [
    {
      command = "systemctl --user restart kanshi";
      always = true;
    }
  ];
}
