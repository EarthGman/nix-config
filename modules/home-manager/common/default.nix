{ outputs, pkgs, lib, config, wallpapers, ... }:
let
  inherit (lib) optionals mkOption types mkIf mkDefault;
  # alacritty =
  #    if (cfg.alacritty != "") then {
  #       ${cfg.alacritty}.enable = true;
  #    } else { };
  #
  enableDesktopProfile = profile:
    let
      cfg = config.custom.profiles.desktops;
    in
    if (cfg.${profile} != "" && cfg.${profile} != null) then
      {
        ${cfg.${profile}}.enable = true;
      }
    else { };

  enableProfile = profile:
    let
      cfg = config.custom.profiles;
    in
    if (cfg.${profile} != "" && cfg.${profile} != null) then
      {
        ${cfg.${profile}}.enable = true;
      }
    else { };

in
{
  imports = [ ./xsession.nix ];

  options = {
    # custom option allows various configuration to reference your preferred program to execute.
    # for example keybinds for Tiling Window Managers will open a browser or file manager based on what you set here.
    custom = {
      editor = mkOption {
        description = "String that will be exported 1:1 to your EDITOR env variable in your shell";
        type = types.str;
        default = "";
      };

      terminal = mkOption {
        description = "which terminal emulator is used by default";
        type = types.str;
        default = "";
      };

      fileManager = mkOption {
        description = "preferred fileManager";
        type = types.str;
        default = "";
      };

      browser = mkOption {
        description = "preferred browser";
        type = types.str;
        default = "";
      };

      wallpaper = mkOption {
        description = "path to preferred default wallpaper";
        type = types.path;
        default = builtins.fetchurl wallpapers.default;
      };

      profiles = import ./profile-opts.nix { inherit lib; };
    };
  };

  config = {
    nixpkgs = {
      overlays = builtins.attrValues outputs.overlays;
      config.allowUnfree = true;
    };

    # things needed for modules to work
    home.packages = with pkgs; [
      coreutils-full
      psmisc
      gnused
      brightnessctl
      pamixer
      imagemagick
    ] ++ optionals (config.services.network-manager-applet.enable) [
      networkmanagerapplet
    ];

    # enable the profile requested by config.custom.profiles
    profiles = {
      alacritty = enableProfile "alacritty";
      bat = enableProfile "bat";
      dunst = enableProfile "dunst";
      fastfetch = enableProfile "fastfetch";
      firefox = enableProfile "firefox";
      kitty = enableProfile "kitty";
      rofi = enableProfile "rofi";
      swaylock = enableProfile "swaylock";
      stylix = enableProfile "stylix";
      starship = enableProfile "starship";
      lazygit = enableProfile "lazygit";
      tmux = enableProfile "tmux";
      vscode = enableProfile "vscode";
      rmpc = enableProfile "rmpc";
      polybar = enableProfile "polybar";
      yazi = enableProfile "yazi";
      waybar = enableProfile "waybar";
      zsh = enableProfile "zsh";

      # the one black sheep
      desktopThemes =
        if (config.custom.profiles.desktopTheme != "") then {
          ${config.custom.profiles.desktopTheme}.enable = true;
        }
        else { };

      desktops = {
        i3 = enableDesktopProfile "i3";
        sway = enableDesktopProfile "sway";
        hyprland = enableDesktopProfile "hyprland";
      };
    };

    # enable programs using the custom user preferences
    # use this list for the string values of the custom options, must match exactly
    programs =
      let
        cfg = config.custom;
      in
      {
        home-manager.enable = mkDefault true;
        neovim-custom.enable = mkDefault (cfg.editor == "nvim");
        vscode.enable = mkDefault (cfg.editor == "codium");
        zed.enable = mkDefault (cfg.editor == "zed");

        # browsers
        firefox.enable = mkDefault (cfg.browser == "firefox");
        brave.enable = mkDefault (cfg.browser == "brave");

        # file managers
        nautilus.enable = mkDefault (cfg.fileManager == "nautilus");
        dolphin.enable = mkDefault (cfg.fileManager == "dolphin");
        yazi.enable = mkDefault (cfg.fileManager == "yazi");

        #terminals
        kitty.enable = mkDefault (cfg.terminal == "kitty");
        ghostty.enable = mkDefault (cfg.terminal == "ghostty");
        alacritty.enable = mkDefault (cfg.terminal == "alacritty");
      };
  };
}
