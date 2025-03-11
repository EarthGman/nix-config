# this modules defines a few custom options and shared configuration among all users on all machines
{ pkgs, lib, outputs, config, ... }:
let
  inherit (lib) mkDefault mkOption mkIf types;
in
{
  options = {
    # custom option allows various configuration to reference your preferred program to execute.
    # for example keybinds for Tiling Window Managers will open a browser or file manager based on what you set here.
    custom = {
      editor = mkOption {
        description = "String that will be exported 1:1 to your EDITOR env variable in your shell";
        type = types.str;
        default = "nvim";
      };
      terminal = mkOption {
        description = "which terminal emulator is used by default";
        type = types.str;
        default = "kitty";
      };
      fileManager = mkOption {
        description = "preferred fileManager";
        type = types.str;
        default = "nautilus";
      };
      browser = mkOption {
        description = "preferred browser";
        type = types.str;
        default = "firefox";
      };
    };
  };

  config = {
    home.packages = mkIf (config.services.network-manager-applet.enable) [
      # why this doesn't just install into home.packages by default baffles me
      # if waybar runs as a service without this installed the icon will be missing
      pkgs.networkmanagerapplet
    ];
    xdg.userDirs = {
      # enable and create common Directories (Downloads, Documents, Music, etc)
      enable = mkDefault true;
      createDirectories = mkDefault true;
    };
    programs = let cfg = config.custom; in {

      # the current vesktop release does not properly communicate with wayland portals for screensharing
      discord.package = pkgs.stable.vesktop;

      home-manager.enable = true;
      starship.enable = true;
      gh = {
        enable = true;
        gitCredentialHelper.enable = true;
      };
      git.enable = true; # enable user level git configuration (do not forget to set programs.git.userName and programs.git.userEmail in your profile under /profiles/home-manager)
      bat.enable = true; # allow bat to be themed by stylix
      zsh.enable = true; # force zsh since it is the best shell after all

      # enable various programs based on the user's preferences
      neovim-custom.enable = mkDefault (cfg.editor == "nvim");
      vscode.enable = mkDefault (cfg.editor == "codium");
      zed.enable = mkDefault (cfg.editor == "zed");

      # browsers
      firefox.enable = mkDefault (cfg.browser == "firefox");
      brave.enable = mkDefault (cfg.browser == "brave");

      # file managers
      nautilus.enable = mkDefault (cfg.fileManager == "nautilus");
      yazi.enable = mkDefault (cfg.fileManager == "yazi");
    };

    nixpkgs = {
      overlays = builtins.attrValues outputs.overlays;
      config.allowUnfree = true;
    };
  };
}
