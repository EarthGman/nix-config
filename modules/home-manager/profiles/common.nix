# default HM profiles for all users
{ pkgs, lib, outputs, config, ... }:
let
  inherit (lib) mkDefault optionals mkEnableOption mkIf;
in
{
  options.profiles.common.enable = mkEnableOption "default hm profile";
  config = mkIf config.profiles.common.enable {

    profiles.zsh.enable = true;

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

    xdg.userDirs = {
      # enable and create common Directories (Downloads, Documents, Music, etc)
      enable = mkDefault true;
      createDirectories = mkDefault true;
    };

    programs = let cfg = config.custom; in {
      home-manager.enable = mkDefault true;
      starship.enable = mkDefault true;
      gh = {
        enable = mkDefault true;
        gitCredentialHelper.enable = true;
      };
      git.enable = mkDefault true;
      bat.enable = mkDefault true;
      eza.enable = mkDefault true;
      zoxide = {
        enable = mkDefault true;
        options = mkDefault [
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
  };
}
