# default HM profiles for all users
{ lib, config, ... }:
let
  inherit (lib) autoImport mkDefault mkEnableOption mkIf;
in
{
  imports = autoImport ./.;

  options.profiles.default.enable = mkEnableOption "default hm profile";
  config = mkIf config.profiles.default.enable {
    custom = {
      terminal = mkDefault "kitty";
      fileManager = mkDefault "nautilus";
      editor = mkDefault "nvim";
      browser = mkDefault "firefox";

      # enable all default profiles
      profiles =
        let
          default = mkDefault "default";
        in
        {
          fastfetch = default;
          kitty = default;
          rofi = default;
          swaylock = default;
          vscode = default;
          waybar = default;
          zsh = default;
          tmux = default;
          desktopTheme = mkDefault "cosmos";
        };
    };

    xdg.userDirs = {
      # enable and create common Directories (Downloads, Documents, Music, etc)
      enable = mkDefault true;
      createDirectories = mkDefault true;
    };

    programs = {
      gh = {
        enable = mkDefault true;
        gitCredentialHelper.enable = true;
      };
      starship.enable = mkDefault true;
      git.enable = mkDefault true;
      bat.enable = mkDefault true;
      eza.enable = mkDefault true;
      zsh.enable = mkDefault true;
      zoxide = {
        enable = mkDefault true;
        options = mkDefault [
          "--cmd j"
        ];
      };
    };
  };
}
