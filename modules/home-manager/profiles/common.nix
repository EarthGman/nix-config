# default HM profiles for all users
{ pkgs, lib, config, ... }:
let
  inherit (lib) mkDefault optionals mkEnableOption mkIf;
in
{
  options.profiles.common.enable = mkEnableOption "default hm profile";
  config = mkIf config.profiles.common.enable {
    custom = {
      terminal = mkDefault "kitty";
      fileManager = mkDefault "nautilus";
      editor = mkDefault "nvim";
      browser = mkDefault "firefox";
    };

    profiles = {
      essentials.enable = mkDefault true;
      fastfetch.default.enable = mkDefault true;
      zsh.default.enable = mkDefault true;
      kitty.default.enable = mkDefault true;
      vscode.default.enable = mkDefault true;
      rofi.default.enable = mkDefault true;
      swaylock.default.enable = mkDefault true;
      waybar.default.enable = mkDefault true;
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
