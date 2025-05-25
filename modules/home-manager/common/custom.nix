{ outputs, pkgs, lib, config, ... }:
let
  inherit (lib) mkOption optionals types mkDefault;
  cfg = config.custom;
in
{
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

    programs = {
      home-manager.enable = mkDefault true;
      # enable various programs based on the user's preferences
      neovim-custom.enable = cfg.editor == "nvim";
      vscode.enable = cfg.editor == "codium";
      zed.enable = cfg.editor == "zed";

      # browsers
      firefox.enable = cfg.browser == "firefox";
      brave.enable = cfg.browser == "brave";

      # file managers
      nautilus.enable = cfg.fileManager == "nautilus";
      yazi.enable = cfg.fileManager == "yazi";

      #terminals
      kitty.enable = cfg.terminal == "kitty";
      ghostty.enable = cfg.terminal == "ghostty";
      alacritty.enable = cfg.terminal == "alacritty";
    };
  };
}
