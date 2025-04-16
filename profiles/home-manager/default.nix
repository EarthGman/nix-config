# this modules defines a few custom options and shared configuration among all users on all machines
{ pkgs, lib, outputs, config, ... }:
let
  inherit (lib) mkDefault mkOption mkIf types;
in
{
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

    home-manager.enable = mkDefault true;
    starship.enable = mkDefault true;
    gh = {
      enable = mkDefault true;
      gitCredentialHelper.enable = true;
    };
    git.enable = mkDefault true;
    bat.enable = mkDefault true;
    zsh.enable = true;
    eza.enable = mkDefault true;
    zoxide = {
      enable = mkDefault true;
      options = [
        "--cmd j"
      ];
    };

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
}
