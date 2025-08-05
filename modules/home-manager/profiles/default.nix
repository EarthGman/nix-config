# default HM profile for all users
{
  pkgs,
  lib,
  config,
  ...
}@args:
let
  desktop = if args ? desktop then args.desktop else "";

  wallpapers = if args ? wallpapers then args.wallpapers else null;
  inherit (lib)
    autoImport
    mkDefault
    mkEnableOption
    mkIf
    ;
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
      wallpaper = mkDefault (builtins.fetchurl wallpapers.default);

      # enable all default profiles
      profiles =
        let
          default = mkDefault "default";
        in
        {
          alacritty = default;
          bat = default;
          fastfetch = default;
          firefox = default;
          fzf = default;
          fish = default;
          dunst = default;
          kitty = default;
          rofi = default;
          swaylock = default;
          swaync = default;
          hyprlock = default;
          starship = default;
          lazygit = default;
          vscode = default;
          polybar = default;
          waybar = default;
          rmpc = default;
          zsh = default;
          yazi = default;
          tmux = default;
          stylix = default;
          desktopTheme = mkDefault "cosmos";

          i3 = default;
          sway = default;
          hyprland = default;
          gnome = default;
        };
    };

    # unified desktop stylizer
    stylix.enable = mkDefault true;

    # set default mimeApp priorities
    xdg = {
      mimeApps = {
        # allow imperative xdg config through nautilus on gnome by default
        enable = mkDefault (desktop != "gnome");
        defaultApplications = {
          "application/pdf" = mkDefault [
            "org.gnome.Evince.desktop"
            "firefox.desktop"
          ];
          "image/png" = mkDefault [
            "org.gnome.gThumb.desktop"
            "gimp.desktop"
          ];
          "image/jpeg" = mkDefault [
            "org.gnome.gThumb.desktop"
            "gimp.desktop"
          ];
          "image/webp" = mkDefault [
            "org.gnome.gThumb.desktop"
            "gimp.desktop"
          ];
          "image/gif" = mkDefault [
            "org.gnome.gThumb.desktop"
            "gimp.desktop"
          ];
          "video/mp4" = mkDefault [
            "vlc.desktop"
            "org.gnome.gitlab.YaLTeR.VideoTrimmer.desktop"
          ];
        };
      };

      userDirs = {
        # enable and create common Directories (Downloads, Documents, Music, etc)
        enable = mkDefault true;
        createDirectories = mkDefault true;
      };
    };

    home.sessionVariables = {
      # required for some scripts
      XDG_SCREENSHOTS_DIR = mkDefault "${config.xdg.userDirs.pictures}/screenshots";
    };

    programs = {
      gh = {
        enable = mkDefault true;
        gitCredentialHelper.enable = true;
      };
      nh = {
        enable = mkDefault true;
        clean = {
          enable = mkDefault true;
          extraArgs = mkDefault "--keep-since 4d --keep 3";
        };
      };
      starship.enable = mkDefault true;
      neovim-custom.package = mkDefault pkgs.nvim;
      git.enable = mkDefault true;
      tmux.enable = mkDefault true;
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
